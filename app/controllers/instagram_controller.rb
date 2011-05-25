class InstagramController < ApplicationController
  def index
    instagram_client = HTTPClient.new
    instagram_response = instagram_client.get_content("https://api.instagram.com/v1/tags/#{APP_CONFIG['instagram_tag']}/media/recent?client_id=#{APP_CONFIG['instagram_client_id']}")
    instagram_response = JSON.parse(instagram_response)
    @instagram_images = instagram_response['data'].first(10).collect { |img| img["images"]["standard_resolution"]["url"] }

    respond_to do |format|
      format.html { render :partial => 'index' }
    end
  end
end
