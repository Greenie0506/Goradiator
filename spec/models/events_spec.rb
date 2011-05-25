require 'spec_helper'

describe Events do
  context "creating an event" do
    it "should be possible" do
      event = Factory.build(:events)
      event.should be_valid
    end

    it "should have a name and time" do
      no_title = Factory.build(:events, :title => nil)
      no_time = Factory.build(:events, :time => nil)

      no_title.should_not be_valid
      no_time.should_not be_valid
    end

    it "should have a unique time" do
      now = Time.now
      event1 = Factory(:events, :time => now)
      event2 = Factory.build(:events, :time => now)

      event2.should_not be_valid
    end
  end

  context "getting the upcoming event" do
    before do
      @e1 = Factory.create(:events, :time => Time.now + 1.hour)
      @e2 = Factory.create(:events, :time => Time.now + 2.hour)
    end

    it "should be the next one" do
      Events.upcoming.should_not == @e2
      Events.upcoming.should == @e1
    end

    it "should be after now" do
      Time.now.should be < Events.upcoming.time
    end
  end
end


