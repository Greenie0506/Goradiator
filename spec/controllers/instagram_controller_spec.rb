require 'spec_helper'

describe InstagramController do
render_views
  before do
    @http_client_dbl = double()
    HTTPClient.stub(:new) {@http_client_dbl}

    @instagram_dbl = {'images' => {'standard_resolution' => {'url' => 'newfake.jpg'} } }
    @instagram_dbl_cached = {'images' => {'standard_resolution' => {'url' => 'cachedfake.jpg'} } }
    @api_response = {'data' => [@instagram_dbl, @instagram_dbl]}
    @cache_response = {'data' => {'data' => [@instagram_dbl_cached, @instagram_dbl_cached]} }
    @cache_response.stub(:data).and_return(@cache_response['data'])
    @cache_response.stub(:delete)
    @empty_response = {'data' => []}

    JSON.stub(:parse).with(@api_response).and_return(@api_response)
    JSON.stub(:parse).with(@cache_response.data).and_return(@cache_response.data)
    JSON.stub(:parse).with(@empty_response).and_return(@empty_response)

    ApiCache.stub(:create)
  end

  context "there are Instagram images" do
    before do
      @http_client_dbl.stub(:get_content).and_return(@api_response)
    end

    context "there is valid data in the cache" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(@cache_response)
        @cache_response.stub(:is_expired?).and_return(false)
      end

      it "should get the data in the cache and return an array of (cached) image urls" do
        get 'index'
        assigns(:instagram_images).should == @cache_response.data['data']
      end
    end

    context "there is expired data in the cache" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(@cache_response)
        @cache_response.stub(:is_expired?).and_return(true)
      end

      it "should get the data from instagram and return an array of (new) image urls" do
        get 'index'
        assigns(:instagram_images).should == @api_response['data']
      end

      it "should store the data in the cache" do
        @cache_response.should_receive(:delete)
        ApiCache.should_receive(:create)
        get 'index'
      end
    end

    context "there is no data in the cache" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(nil)
      end

      it "should get the data from instagram and return an array of (new) image urls" do
        get 'index'
        assigns(:instagram_images).should == @api_response['data'] 
      end

      it "should store the data in the cache" do
        ApiCache.should_receive(:create)
        get 'index'
      end
    end
  end

  context "there are no Instagram images" do

    before do
      ApiCache.stub(:find_by_service_type).and_return(nil)
      @http_client_dbl.stub(:get_content).and_return(@empty_response)
    end

    it "should show a notice when there are no instagram images" do
      get :index

      doc = Nokogiri::HTML(response.body)
      doc.css("#no_instagram").text.should include("Take pictures and tag them")
      doc.css("#instagram_images").should_not be_present
    end 
  end
end
