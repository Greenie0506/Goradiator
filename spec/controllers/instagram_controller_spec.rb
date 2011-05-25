require 'spec_helper'

describe InstagramController do
  context "loading Instagram images" do
    render_views

    before :each do
      instagram_client = double()
      HTTPClient.stub(:new) {instagram_client}
      @instagram_response = double()
      instagram_client.stub(:get_content).and_return(@instagram_response)
      JSON.stub(:parse).and_return(@instagram_response)
    end
    
    it "should get the most recent instagram photos with the tag" do
      instagram_images = ["Fake image"]
      @instagram_response.stub_chain(:[], :first, :collect).and_return(instagram_images)
      get :index
      
      assigns(:instagram_images).should include("Fake image")
    end

    it "should show a notice when there are no instagram images" do
      instagram_images = []
      @instagram_response.stub_chain(:[], :first, :collect).and_return(instagram_images)
      get :index

      doc = Nokogiri::HTML(response.body)
      doc.css("#no_instagram").text.should == "Take pictures and tag them \"goruco\""
      doc.css("#instagram_images").should_not be_present
    end
  end
end
