class Events < ActiveRecord::Base
  validates_presence_of :title, :time
  validates_uniqueness_of :time

  default_scope :order => 'time ASC'

  def self.upcoming
    Events.all.each do |event|
      if Time.now < event.time
        return event
      end
    end
  end
end
