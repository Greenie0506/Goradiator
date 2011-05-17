require 'spec_helper'

describe Events do
  context "creating an event" do
    before do
      @event = Factory.create(:events)
    end

    it "should not be nil" do
      @event.should_not be_nil
    end

    it "should have a name, time, and speaker" do
      @event.name.should_not be_nil
      @event.speaker.should_not be_nil
      @event.time.should_not be_nil
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


