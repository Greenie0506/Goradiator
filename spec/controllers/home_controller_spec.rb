require 'spec_helper'

describe HomeController do
  context "Events" do
    before :each do
      @double_next_event = double()
      Events.stub(:upcoming) {@double_next_event}
    end
    it "should have an @event object that is the next event" do
      get 'index'
      assigns(:event).should == @double_next_event
    end
  end
  context "Twitter" do
    before :each do
      @double_twitter_search = double()
      Twitter::Search.stub(:new) { @double_twitter_search }
      @double_tweets = double("hello")
      @double_twitter_search.stub_chain(:hashtag, :result_type, :per_page, :fetch).and_return(@double_tweets)
      @double_twitter_search.stub_chain(:from, :result_type, :per_page, :fetch).and_return(@double_tweets)
      @double_twitter_search.stub(:clear)
      get 'index'
    end
    it "should get the tweets with the configured hashtag" do
      assigns(:hashtag_tweets).should == @double_tweets
    end
    it "should get the events twitter handle tweets" do
      assigns(:handle_tweets).should == @double_tweets
    end
  end
end
