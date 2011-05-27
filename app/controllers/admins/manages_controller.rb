require 'yaml'

class Admins::ManagesController < ApplicationController 
  layout "admin"

  before_filter :authenticate_admin!

  def show 
    config = YAML.load_file("config/config.yml")

    @conference = Conference.new
    @conference.twitter_handle = config["twitter_handle"]
    @conference.twitter_hashtag = config["twitter_hashtag"]
    @conference.instagram_client_id = config["instagram_client_id"]
    @conference.instagram_hashtag = config["instagram_hashtag"]
    @conference.foursquare_venue_id = config["foursquare_venue_id"]
    @conference.foursquare_venue_name = config["foursquare_venue_name"]
    @conference.foursquare_oauth_token = config["foursquare_oauth_token"]
    @conference.sponsors = config["sponsors"]
    @conference.events = config["events"]
  end

  def update
    config = YAML.load_file("config/config.yml")

    @conference = params[:conference]
    @conference["sponsors"] = config["sponsors"]
    @conference["events"] = config["events"]
   
    @conference.each do |key, value|
      APP_CONFIG[key] = value
    end

    File.open("config/config.yml", "w") { |f| YAML.dump(@conference, f) }

    redirect_to :manages
  end
end
