class EventsController < ApplicationController
  def index
    @event = Events.upcoming
    respond_to do |format|
      format.js { render :partial => 'index' }
    end
  end
end

