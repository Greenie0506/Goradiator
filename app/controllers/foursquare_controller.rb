class FoursquareController < ApplicationController
  def index
    foursquare_client = HTTPClient.new
    fsq_url = "https://api.foursquare.com/v2/venues/#{APP_CONFIG['foursquare_vendor_id']}/herenow?oauth_token=#{APP_CONFIG['foursquare_oauth_token']}"
    
    foursquare_response = foursquare_client.get_content(fsq_url)
    foursquare_response = JSON.parse(foursquare_response)
    @foursquare_herenow = foursquare_response['response']['hereNow']['items']
    
    respond_to do |format|
      format.html { render :partial => 'index' }
    end
  end
end
