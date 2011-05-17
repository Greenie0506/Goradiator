class HomeController < ApplicationController

  def index
    @event = Events.upcoming
  end

end
