module HomeHelper

  def official_tweets i
    search = Twitter::Search.new
    return search.from("goruco").result_type("recent").per_page(i)
  end

  def hash_tweets i
    search = Twitter::Search.new
    return search.hashtag("goruco").result_type("recent").per_page(i)
  end
end
