class FoursquareController < ApplicationController
  def index
    fsq_venue_id = APP_CONFIG['foursquare_venue_id']
    @fsq_venue_name = APP_CONFIG['foursquare_venue_name']
    service_type = "fsq_venue_#{fsq_venue_id}"
    valid_for = 60 #in seconds
    data = cache_data(service_type, fsq_venue_id, valid_for)
    data = JSON.parse(data)
    @foursquare_herenow = data['response']['hereNow']['items']

    respond_to do |format|
      format.html { render :partial => 'index' }
    end
  end

  private
  def foursquare_call fsq_venue_id
    in_url = "https://api.foursquare.com/v2/venues/#{fsq_venue_id}/herenow?oauth_token=#{APP_CONFIG['foursquare_oauth_token']}" 
    http_client = HTTPClient.new
    return http_client.get_content(in_url)
  end

  def cache_data service_type, fsq_venue_id, valid_for
    cache = ApiCache.find_by_service_type(service_type)
    if (cache.nil? || cache.is_expired?)
      if (not cache.nil?)
        cache.delete
      end
      data = foursquare_call fsq_venue_id
      ApiCache.create(:service_type => service_type,
                      :valid_for => valid_for,
                      :data => data)
    else
      data = cache.data
    end
    return data
  end

end
