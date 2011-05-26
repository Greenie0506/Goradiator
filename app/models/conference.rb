class Conference 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :twitter_handle, 
                :twitter_hash, 
                :instagram_tag, 
                :instagram_clent_id, 
                :events, 
                :foursquare_venue, 
                :foursquare_oauth_token

  def initialize
    
  end
    
  def persisted?
    false
  end
end
