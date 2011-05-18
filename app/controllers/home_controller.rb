class HomeController < ApplicationController

  def index
    @event = Events.upcoming
    search = Twitter::Search.new
    @handle_tweets = search.from(APP_CONFIG['twitter_handle']).result_type("recent").per_page(5).fetch
    search.clear
    @hashtag_tweets = search.hashtag(APP_CONFIG['twitter_hashtag']).result_type("recent").per_page(5).fetch
  end
end
