class TwitterController < ApplicationController
  def handle
    @twitter_handle = APP_CONFIG['twitter_handle']
    service_type = "twitter_handle_#{@twitter_handle}"
    twitter_query = "from%3A#{@twitter_handle}"
    num_tweets = 1
    valid_for = 15 #in seconds
    data = cache_data(service_type, twitter_query, num_tweets, valid_for)
    @handle_tweets = JSON.parse(data)['results']

    respond_to do |format|
      format.html { render :partial => 'handle' }
    end
  end

  def hashtag
    @twitter_hashtag = APP_CONFIG['twitter_hashtag']
    service_type = "twitter_hashtag_#{@twitter_hashtag}"
    twitter_query = "%23#{@twitter_hashtag}"
    num_tweets = 5
    valid_for = 5 #in seconds
    data = cache_data(service_type, twitter_query, valid_for, num_tweets)
    @hashtag_tweets = JSON.parse(data)['results']

    respond_to do |format|
      format.html { render :partial => 'hashtag' }
    end
  end

  protected
  def twitter_call twitter_query, num_tweets
    tw_url = "http://search.twitter.com/search.json?q=#{twitter_query}&result_type=recent&rpp=#{num_tweets}"
    http_client = HTTPClient.new
    return http_client.get_content(tw_url)
  end

  def cache_data service_type, twitter_query, num_tweets, valid_for
    cache = ApiCache.find_by_service_type(service_type)
    if (cache.nil? || cache.is_expired?)
      if (not cache.nil?)
        cache.delete
      end
      data = twitter_call(twitter_query, num_tweets)
      ApiCache.create(:service_type => service_type,
                      :valid_for => valid_for,
                      :data => data)
    else
      data = cache.data
    end
    return data
  end
end
