require 'spec_helper'

describe InstagramController do
  context "loading Instagram images" do
    before :each do
      instagram_client = double()
      HTTPClient.stub(:new) {instagram_client}
      double_instagram_images = "Fake image"
      instagram_response = double()
      instagram_client.stub(:get_content).and_return(instagram_response)
      JSON.stub(:parse).and_return(instagram_response)
      instagram_response.stub_chain(:[], :first, :collect).and_return(double_instagram_images)
      get 'index'
    end
    
    it "should get the most recent instagram photos with the tag" do
      assigns(:instagram_images).should == "Fake image"
    end
  end
end
