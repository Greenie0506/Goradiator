require 'spec_helper'

describe ApiCache do
  before do
    @cache = ApiCache.new(
      :service_type => "twitter_handle", 
      :data => "{}",
      :valid_for => 4.hours
    )
  end

  context "valid" do
    it "should be valid" do
      @cache.should be_valid
    end

    it "should be expired when item is older than valid_for" do
      Timecop.freeze Time.now do
        @cache.valid_for = 4.hours
        @cache.created_at = 5.hours.ago
        @cache.is_expired?.should be(true)
      end
    end

    it "should not be expired when item is newer than valid_for" do
      Timecop.freeze Time.now do
        @cache.valid_for = 4.hours
        @cache.created_at = 3.hours.ago
        @cache.is_expired?.should be(false)
      end
    end
  end

  context "invalid" do
    it "requires data" do
      @cache.data = nil
      @cache.should_not be_valid
    end

    it "requires service_type" do
      @cache.service_type = nil
      @cache.should_not be_valid
    end

    it "requires valid_for" do
      @cache.valid_for = nil
      @cache.should_not be_valid
    end
  end
end
