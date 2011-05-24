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
end
