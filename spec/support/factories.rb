Factory.define :events do |e|
  e.time {Time.new(2011, 6, 4, 12, 00)}
  e.title "Nicholas Greenfield is the best"
  e.speaker "Nicholas Greenfield"
end

Factory.define :admin do |a|
  a.email "job@bluth.net"
  a.password "banana"
  a.password_confirmation "banana"
end
