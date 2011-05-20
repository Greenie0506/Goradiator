class EventsController < ApplicationController
  def index
    @event = Events.upcoming
    #APP_CONFIG['events'].each do |event|
      #if Time.now < event.time
        #@event = event
        #break
      #end
    #end
    #@event = "There is no event!"
    respond_to do |format|
      format.js { render :partial => 'index' }
    end
  end
end

