require 'spec_helper'

describe TwitterController do
  context "loading Twitter content" do
    before :each do
      double_twitter_search = double()
      Twitter::Search.stub(:new) { double_twitter_search }
      double_tweets = "Fake Tweet"
      double_twitter_search.stub_chain(:hashtag, :result_type, :per_page, :fetch).and_return(double_tweets)
      double_twitter_search.stub_chain(:from, :result_type, :per_page, :fetch).and_return(double_tweets)
      double_twitter_search.stub(:clear)
      get 'index'
    end
    it "should get the tweets with the configured hashtag" do
      assigns(:hashtag_tweets).should == "Fake Tweet"
    end
    it "should get the events twitter handle tweets" do
      assigns(:handle_tweets).should == "Fake Tweet"
    end
  end
end
