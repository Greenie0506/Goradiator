class InstagramController < ApplicationController
  def index
    @instagram_tag = APP_CONFIG['instagram_tag']
    service_type = "instagram_tag_#{@instagram_tag}"
    valid_for = 20 #in seconds
    data = cache_data(service_type, @instagram_tag, valid_for)
    @instagram_images = JSON.parse(data)['data']

    respond_to do |format|
      format.html { render :partial => 'index' }
    end
  end

  private
  def instagram_call instagram_tag
    in_url = "https://api.instagram.com/v1/tags/#{instagram_tag}/media/recent?client_id=#{APP_CONFIG['instagram_client_id']}"
    http_client = HTTPClient.new
    return http_client.get_content(in_url)
  end

  def cache_data service_type, instagram_tag, valid_for
    cache = ApiCache.find_by_service_type(service_type)
    if (cache.nil? || cache.is_expired?)
      if (not cache.nil?)
        cache.delete
      end
      data = instagram_call instagram_tag
      ApiCache.create(:service_type => service_type,
                       :valid_for => valid_for,
                       :data => data)
    else
      data = cache.data
    end
    return data
  end
end
