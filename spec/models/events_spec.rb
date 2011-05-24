require 'spec_helper'

describe Events do
  context "creating an event" do
    before do
      @event = Factory.build(:events)
    end

    it "should not be nil" do
      @event.valid?.should be(true)
    end

    it "should have a name and time" do
      @event.title = "How to run a bannana stand"
      @event.time = Time.now
      @event.valid?.should be(true)
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


