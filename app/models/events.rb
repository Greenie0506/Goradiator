class Events < ActiveRecord::Base

  default_scope :order => 'time ASC'

  def self.upcoming
    Events.all.each do |event|
      if Time.now < event.time
        return event
      end
    end
  end
end
