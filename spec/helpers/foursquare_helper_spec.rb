require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the FoursquareHelper. For example:
#
# describe FoursquareHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe FoursquareHelper do
  context "assign a css class" do
    it "should be called normal when there are 10 or less avatars" do
      avatar_img = helper.avatar("avatar.jpg", 10)

      node = Nokogiri::XML.parse(avatar_img).child
      node.attribute("class").value.should include("normal")
      node.attribute("class").value.should_not include("small")
      node.attribute("class").value.should_not include("tiny")
    end

    it "should be called small when there are between 11 and 20 avatars" do
      avatar_img = helper.avatar("avatar.jpg", 20)

      node = Nokogiri::XML.parse(avatar_img).child
      node.attribute("class").value.should_not include("normal")
      node.attribute("class").value.should include("small")
      node.attribute("class").value.should_not include("tiny")
    end

    it "should be called xsmall when there are more than 21 avatars" do
      avatar_img = helper.avatar("avatar.jpg", 21)

      node = Nokogiri::XML.parse(avatar_img).child
      node.attribute("class").value.should_not include("normal")
      node.attribute("class").value.should_not include("small")
      node.attribute("class").value.should include("tiny")
    end
  end
end
