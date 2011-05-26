class ApiCache < ActiveRecord::Base
  validates_presence_of :data, :service_type, :valid_for

  def is_expired?
    created_at + valid_for <=  Time.now
  end
end
