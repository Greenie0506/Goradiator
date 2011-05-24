class EventsController < ApplicationController
  def index
    @event = Events.upcoming
    respond_to do |format|
      format.html { render :partial => 'index' }
    end
  end
end

