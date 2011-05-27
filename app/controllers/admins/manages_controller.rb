require 'yaml'

class Admins::ManagesController < ApplicationController 
  layout "admin"

  before_filter :authenticate_admin!

  def show 
    config = YAML.load_file("config/config.yml")

    @conference = Conference.new
    @conference.twitter_handle = config["twitter_handle"]
    @conference.twitter_hashtag = config["twitter_hashtag"]
  end
end
