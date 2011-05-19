class HomeController < ApplicationController

  def index
    @event = Events.upcoming
    search = Twitter::Search.new
    @handle_tweets = search.from(APP_CONFIG['twitter_handle']).result_type("recent").per_page(5).fetch
    search.clear
    @hashtag_tweets = search.hashtag(APP_CONFIG['twitter_hashtag']).result_type("recent").per_page(5).fetch
    instagram_client = HTTPClient.new
    instagram_json = instagram_client.get_content("https://api.instagram.com/v1/tags/gotham/media/recent?client_id=e274913172cd4e75a81d3981159c6938")
    resp = JSON.parse(instagram_json)
    @gram = resp['data'].first(5).collect { |img| img["images"]["standard_resolution"]["url"] }
  end
end
