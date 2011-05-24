require 'spec_helper'

describe TwitterController do
  context "loading Twitter content" do
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
end
