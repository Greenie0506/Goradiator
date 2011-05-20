# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
#
#

Events.delete_all

APP_CONFIG['events'].each do |event|
  Events.create(:time => Time.parse(event['time']), :name => event['name'], :speaker => event['speaker'])
end




