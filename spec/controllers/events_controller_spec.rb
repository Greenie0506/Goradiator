require 'spec_helper'

describe EventsController do
  context "loading upcoming event" do
    before :each do
      double_next_event = "Fake event"
      Events.stub(:upcoming) {double_next_event}
    end
    it "should have an @event object that is the next event" do
      get 'index'
      assigns(:event).should == "Fake event"
    end
  end
end
