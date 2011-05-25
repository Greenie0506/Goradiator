require 'spec_helper'

describe TwitterController do
  context "there are recent tweets" do
    before :each do
      @twitter_search = double()
      Twitter::Search.stub(:new) { @twitter_search }
      @tweet_txt = "Fake Tweet"
      @twitter_search.stub(:clear)
    end

    it "should get the tweets with the configured hashtag" do
      @twitter_search.stub_chain(
        :hashtag, 
        :result_type, 
        :per_page, 
        :fetch
      ).and_return(@tweet_txt)
      get :hashtag

      assigns(:hashtag_tweets).should == "Fake Tweet"
    end

    it "should get the events twitter handle tweets" do
      @twitter_search.stub_chain(
        :from, 
        :result_type, 
        :per_page, 
        :fetch
      ).and_return(@tweet_txt)
      get :handle

      assigns(:handle_tweets).should == "Fake Tweet"
    end
  end

  context "there are no recent tweets" do
    render_views

    it "should not display any handle content" do
      twitter_search = double()
      Twitter::Search.stub(:new) { twitter_search }
      twitter_search.stub(:clear)
      twitter_search.stub_chain(
        :from, 
        :result_type, 
        :per_page, 
        :fetch
      ).and_return([])
      
      get :handle

      assigns(:handle_tweets).should == []
      doc = Nokogiri::HTML(response.body)
      doc.text.should be_empty
    end
  end
end
