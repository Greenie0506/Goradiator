class PhotoStreamController < ApplicationController
  def index
    @images = get_images
    render :layout => false
  end

  private

  def get_images
    cache = ApiCache.where(:service_type => 'photo_stream').first
    if cache.nil? || cache.is_expired?
      cache.try(:destroy)
      images = instagram_images + foursquare_images
      ApiCache.create!(:service_type => "photo_stream", :data => images.to_json, :valid_for => 10)
      return images
    else
      return JSON.parse(cache.data)
    end
  end

  def instagram_images
    in_url = "https://api.instagram.com/v1/tags/#{APP_CONFIG['instagram_hashtag']}/media/recent?client_id=#{APP_CONFIG['instagram_client_id']}"
    http_client = HTTPClient.new
    JSON.parse(http_client.get_content(in_url))['data'].collect do |i|
      i['images']['standard_resolution']['url']
    end
  end

  def foursquare_images
    fsq_url = "https://api.foursquare.com/v2/venues/#{APP_CONFIG['foursquare_venue_id']}/photos?group=venue&oauth_token=GQUMTXRS4MER11IFR1RTRSGK1ZBRZME2TSEZVTOYH1IKBJ1H"
    http_client = HTTPClient.new
    venue = http_client.get_content(fsq_url)
    JSON.parse(venue)['response']['photos']['items'].collect do |image|
      image['url']
    end
  end
end
