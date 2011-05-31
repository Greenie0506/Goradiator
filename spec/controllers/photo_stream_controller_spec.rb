require "spec_helper"

describe PhotoStreamController do
  render_views
  before do
    @instagram_response = {'data' => [{'images' => {'standard_resolution' => {'url' => 'new_instant.jpg'}}}] }
    @foursquare_response = {'response' => {'photos' => {'items' => [{'url' => 'new_4sq.jpg'}]}}}
    stub_request(:get, "https://api.instagram.com/v1/tags/goruco/media/recent?client_id=e274913172cd4e75a81d3981159c6938").
      to_return(:status => 200, :body => @instagram_response.to_json, :headers => {})

    stub_request(:get, "https://api.foursquare.com/v2/venues/#{APP_CONFIG['foursquare_venue_id']}/photos?group=venue&oauth_token=GQUMTXRS4MER11IFR1RTRSGK1ZBRZME2TSEZVTOYH1IKBJ1H").
      to_return(:status => 200, :body => @foursquare_response.to_json, :headers => {})

  end

  context "there are images" do
    context "there is valid data in the cache" do
      before do
        ApiCache.create!(:service_type => 'photo_stream', :data => ['1.jpg', '2.jpg'].to_json, :valid_for => 10)
      end

      it "should get the data from the cache response" do
        get :index
        assigns(:images).should == ['1.jpg', '2.jpg']
      end
    end

    context "when we have to call out to the APIs for images" do
      before do 
        get :index
      end

      it "should include images from both 4sq and Instagram" do
        assigns(:images).should include('new_instant.jpg')
        assigns(:images).should include('new_4sq.jpg')
      end

      it "should save the images into cache" do
        ApiCache.where(:service_type => "photo_stream").first.data.should_not be_blank
      end
    end

    context "if the cache has expired" do
      before do
        ApiCache.create!(:service_type => 'photo_stream', :data => ['1.jpg', '2.jpg'].to_json, :valid_for => -10)
      end

      it "should reload the cache" do
        get :index
        data = JSON.parse(ApiCache.where(:service_type => "photo_stream").first.data)
        data.should include('new_instant.jpg')
        data.should include('new_4sq.jpg')
      end
    end
  end
end
