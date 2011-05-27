class Conference
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :twitter_handle,
                :twitter_hashtag,
                :instagram_hashtag,
                :instagram_client_id,
                :events,
                :foursquare_venue_id,
                :foursquare_venue_name,
                :foursquare_oauth_token,
                :sponsors,
                :events

  def persisted?
    false
  end
end
