require 'spec_helper'

describe FoursquareController do
  render_views

  before do
    @http_client_dbl = double()
    HTTPClient.stub(:new) { @http_client_dbl }
    @avatar = {"user" => {'photo' => "avatar.jpg" } }
    @avatar_cached = {"user" => {'photo' => "cached.jpg"} }
    @api_response = {'response' => {'hereNow' => {'items' => [@avatar, @avatar]} } }
    @cache_response = {'data' => {'response' => {'hereNow' => {'items' => [@avatar_cached, @avatar_cached]} } } }
    @cache_response.stub(:data).and_return(@cache_response['data'])
    @cache_response.stub(:delete)
    @empty_response = {'response' => {'hereNow' => {'items' => []}}}

    JSON.stub(:parse).with(@api_response).and_return(@api_response)
    JSON.stub(:parse).with(@cache_response.data).and_return(@cache_response.data)
    JSON.stub(:parse).with(@empty_response).and_return(@empty_response)

    ApiCache.stub(:create)
  end

  context "people are checked in" do
    before do
      @http_client_dbl.stub(:get_content).and_return(@api_response)
    end

    context "with valid cache data" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(@cache_response)
        @cache_response.stub(:is_expired?).and_return(false)
      end

      it "should get the data in the cache" do
        get 'index'
        assigns(:foursquare_herenow).should == @cache_response.data['response']['hereNow']['items']
      end
    end

    context "with expired cache data" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(@cache_response)
        @cache_response.stub(:is_expired?).and_return(true)
      end

      it "should get the data from foursquare" do
        get 'index'
        assigns(:foursquare_herenow).should == @api_response['response']['hereNow']['items']
      end

      it "should delete the old data and store the new data in the cache" do
        @cache_response.should_receive(:delete)
        ApiCache.should_receive(:create)
        get 'index'
      end
    end

    context "with no cache data" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(nil)
      end

      it "should get the data from foursquare" do
        get 'index'
        assigns(:foursquare_herenow).should == @api_response['response']['hereNow']['items']
      end

      it "should store the data in the cache" do
        ApiCache.should_receive(:create)
        get 'index'
      end
    end

    context "render sizes (for testing simplicity, none in cache)" do
      before do
        ApiCache.stub(:find_by_service_type).and_return(nil)
      end

      it "should render <10 avatars with css class normal" do
        ten_avatars = Array.new(10, @avatar)
        avatars_j = {'response' => {'hereNow' => {'items' => ten_avatars}}} 
        @http_client_dbl.stub(:get_content).and_return(avatars_j)
        JSON.stub(:parse).and_return(avatars_j)

        get :index

        doc = Nokogiri::HTML(response.body)
        doc.css("img.normal").size.should == 10
      end

      it "should render between 11 and 20 avatars with css class small" do
        twenty_avatars = Array.new(20, @avatar)
        avatars_j = {'response' => {'hereNow' => {'items' => twenty_avatars}}} 
        @http_client_dbl.stub(:get_content).and_return(avatars_j)
        JSON.stub(:parse).and_return(avatars_j)

        get :index

        doc = Nokogiri::HTML(response.body)
        doc.css("img.small").size.should == 20
      end

      it "should render 30+ avatars with css class tiny" do
        thirty_avatars = Array.new(30, @avatar)
        avatars_j = {'response' => {'hereNow' => {'items' => thirty_avatars}}} 
        @http_client_dbl.stub(:get_content).and_return(avatars_j)
        JSON.stub(:parse).and_return(avatars_j)

        get :index

        doc = Nokogiri::HTML(response.body)
        doc.css("img.tiny").size.should == 30
      end
    end
  end

  context "no one is checked in" do
    before do
      ApiCache.stub(:find_by_service_type).and_return(nil)
      @http_client_dbl.stub(:get_content).and_return(@empty_response)
    end
    it "should show a notification" do
      get :index

      doc = Nokogiri::HTML(response.body)
      doc.css("img").should_not be_present
      doc.css("#no_checkins").text.should == "Check into Pace University on foursquare"
    end
  end
end
