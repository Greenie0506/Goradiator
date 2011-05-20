require 'spec_helper'

describe HomeController do
  context "Events" do
    before :each do
      double_next_event = "Fake event"
      Events.stub(:upcoming) {double_next_event}
    end
    it "should have an @event object that is the next event" do
      get 'index'
      assigns(:event).should == "Fake event"
    end
  end
  context "Twitter" do
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
  context "Instagram" do
    before :each do
      instagram_client = double()
      HTTPClient.stub(:new) {instagram_client}
      double_instagram_images = "Fake image"
      instagram_response = double()
      instagram_client.stub(:get_content).and_return(instagram_response)
      JSON.stub(:parse).and_return(instagram_response)
      instagram_response.stub_chain(:first, :collect).and_return(double_instagram_images)
      get 'index'
    end
    it "should get the most recent instagram photos with the tag" do
      assigns( :instagram_images).should == "Fake image"
      puts instagram_images
    end
  end
end
