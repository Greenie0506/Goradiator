require 'spec_helper'

describe TwitterController do
  render_views
  before do
    @http_client_dbl = double()
    HTTPClient.stub(:new) { @http_client_dbl }

    @tweet_dbl1 = {'profile_image_url' => 'fake.png',
      'text' => 'fake text',
      'from_user' => 'fake user'}
    @tweet_dbl2 = {'profile_image_url' => 'cached.png',
      'text' => 'fake text',
      'from_user' => 'fake user'}
    @api_response = { 'results' => [@tweet_dbl1, @tweet_dbl1] }
    @cache_response = {'data' => { 'results' => [@tweet_dbl2, @tweet_dbl2] } }
    @cache_response.stub(:data).and_return(@cache_response['data'])
    @cache_response.stub(:delete)
    @empty_response = {'results' => []}

    JSON.stub(:parse).with(@api_response).and_return(@api_response)
    JSON.stub(:parse).with(@cache_response.data).and_return(@cache_response.data)
    JSON.stub(:parse).with(@empty_response).and_return(@empty_response);

    ApiCache.stub(:create)
  end

  context "there are recent tweets" do
    before do
      @http_client_dbl.stub(:get_content).and_return(@api_response)
    end

    context "there are valid tweets in the cache" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(@cache_response)
        @cache_response.stub(:is_expired?).and_return(false)
      end

      it "should get the tweets in the cache" do
        get 'handle'
        assigns(:handle_tweets).should == [@tweet_dbl2, @tweet_dbl2]

        get 'hashtag'
        assigns(:hashtag_tweets).should == [@tweet_dbl2, @tweet_dbl2]
      end
    end

    context "there are expired tweets in the cache" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(@cache_response)
        @cache_response.stub(:is_expired?).and_return(true)
      end

      it "should get the tweets from twitter" do
        get 'handle'
        assigns(:handle_tweets).should == [@tweet_dbl1, @tweet_dbl1]

        get 'hashtag'
        assigns(:hashtag_tweets).should == [@tweet_dbl1, @tweet_dbl1]
      end

      it "should delete the old and store the new" do
        @cache_response.should_receive(:delete)
        ApiCache.should_receive(:create)
        get 'handle'

        @cache_response.should_receive(:delete)
        ApiCache.should_receive(:create)
        get 'hashtag'
      end
    end

    context "there are no tweets in the cache" do
      before do
        @http_client_dbl.should
        ApiCache.stub(:find_by_service_type).and_return(nil)
      end

      it "should get the tweets from twitter" do
        get 'handle'
        assigns(:handle_tweets).should == [@tweet_dbl1, @tweet_dbl1]

        get 'hashtag'
        assigns(:hashtag_tweets).should == [@tweet_dbl1, @tweet_dbl1]
      end

      it "should store them in the database" do

        ApiCache.should_receive(:create)
        get 'handle'

        ApiCache.should_receive(:create)
        get 'hashtag'
      end
    end
  end

  context "there are no recent tweets" do
    render_views

    before do
      ApiCache.stub(:find_by_service_type).and_return(nil)
      @http_client_dbl.stub(:get_content).and_return(@empty_response)
    end

    it "should not display any handle content" do
      get :handle

      assigns(:handle_tweets).should == []
      doc = Nokogiri::HTML(response.body)
      doc.text.should be_empty
    end

    it "should give a message if no hashtag content" do
      get :hashtag

      assigns(:hashtag_tweets).should == []
      doc = Nokogiri::HTML(response.body)
      doc.css("#noTweets").text.should == "Tweet with \"#goruco\""
    end
  end

end
