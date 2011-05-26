require 'yaml'

class Admins::ManagesController < ApplicationController
  layout "admin"

  def show 
    config = YAML.load_file("config/config.yml")

    @conference = Conference.new
    @conference.twitter_handle = config["twitter_handle"]
    @conference.twitter_hash = config["twitter_hash"]
  end
end
