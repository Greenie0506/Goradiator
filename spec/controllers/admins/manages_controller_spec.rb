require 'spec_helper'

describe Admins::ManagesController do
  render_views

  context "managing conference config" do
    it "should fill in the twitter handle from the config file" do
      config = { "twitter_handle" => "bluth_empires" }
      YAML.should_receive(:load_file).and_return(config)
      get :show

      assigns(:conference).twitter_handle.should == "bluth_empires"
    end
  end
end
