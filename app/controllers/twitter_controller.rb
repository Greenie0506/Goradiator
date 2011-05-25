class TwitterController < ApplicationController
  def handle
    search = Twitter::Search.new
    recent_tweets = search.from(APP_CONFIG['twitter_handle']).result_type("recent")
    @handle_tweets = recent_tweets.per_page(1).fetch

    respond_to do |format|
      format.html { render :partial => 'handle' }
    end
  end

  def hashtag
    search = Twitter::Search.new
    recent_hash_tweets = search.hashtag(APP_CONFIG['twitter_hashtag']).result_type("recent")
    @hashtag_tweets = recent_hash_tweets.per_page(5).fetch

    respond_to do |format|
      format.html { render :partial => 'hashtag' }
    end
  end

  protected
  def handle_service_type
    "twitter_handle_#{APP_CONFIG['twitter_handle']}"
  end

  def hash_service_type
    "twitter_hash_#{APP_CONFIG['twitter_hash']}"
  end
end
