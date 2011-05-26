require 'spec_helper'

describe Admin do
  context "create user" do
    it "should be valid" do
      user = Factory.build(:admin)
      user.should be_valid
    end

    it "should be invalid without password" do
      no_pass_user = Factory.build(:admin, :password => nil)
      no_pass_user.should_not be_valid
    end

    it "should be invalid when password_confirmation doesn't match password" do
      user = Factory.build(:admin, :password => "banana", :password_confirmation => "chocolate")
      user.should_not be_valid
    end

    it "should be invalid when email is not in the correct format" do
      user = Factory.build(:admin, :email => "blah")
      user_with_at = Factory.build(:admin, :email => "blah@blah")
 
      user.should_not be_valid
      user_with_at.should_not be_valid
    end
  end
end
