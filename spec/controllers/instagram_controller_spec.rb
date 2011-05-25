require 'spec_helper'

describe InstagramController do
  context "loading Instagram images" do
    render_views

    before :each do
      instagram_client = double()
      HTTPClient.stub(:new) {instagram_client}
      @instagram_images = ["Fake image"]
      @instagram_response = double()
      instagram_client.stub(:get_content).and_return(@instagram_response)
      JSON.stub(:parse).and_return(@instagram_response)
    end
    
    it "should get the most recent instagram photos with the tag" do
      @instagram_response.stub_chain(:[], :first, :collect).and_return(@instagram_images)
      get :index
      
      assigns(:instagram_images).should include("Fake image")
    end

    it "should show a notice when there are no instagram images" do
      
    end
  end
end
