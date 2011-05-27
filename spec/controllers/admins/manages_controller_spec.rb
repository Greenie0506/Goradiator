require 'spec_helper'

describe Admins::ManagesController do
  render_views

  context "authenticated user" do

  end

  context "managing conference config" do
    it "should fill in the twitter handle from the config file" do
      config = { "twitter_handle" => "bluth_empires" }
      YAML.should_receive(:load_file).and_return(config)
      get :show

      assigns(:conference).twitter_handle.should == "bluth_empires"
    end

    it "should fill in the twitter hashtag from the config file" do
      config = { "twitter_hashtag" => "nerd" }
      YAML.should_receive(:load_file).and_return(config)
      get :show

      assigns(:conference).twitter_hashtag.should == "nerd"
    end
  end
end
