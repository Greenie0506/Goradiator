class TwitterController < ApplicationController
  def index
    search = Twitter::Search.new
    
    recent_tweets = search.from(APP_CONFIG['twitter_handle']).result_type("recent")
    @handle_tweets = recent_tweets.per_page(1).fetch
    search.clear
    
    recent_hash_tweets = search.hashtag(APP_CONFIG['twitter_hashtag']).result_type("recent")
    @hashtag_tweets = recent_hash_tweets.per_page(5).fetch
    
    respond_to do |format|
      format.js { render :partial => 'index' }
    end
  end
end
