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

events = Events.create([{:time => Time.new(2011, 6, 4, 12, 00), :name => "Nick and Nick give a wonderful talk", :speaker => "Nick and Nick"},
                        {:time => Time.local(2011, 6, 7, 13, 00), :name => "Best talk on rails ever!!!", :speaker => "Chewbacca"},
                        {:time => Time.local(2011, 6, 2, 14, 00), :name => "MMMMM Dr. Pepper", :speaker => "Thor"},
                        {:time => Time.local(2011, 6, 3, 15, 00), :name => "Check out this lightsaber", :speaker => "Luke Skywalker"}])





