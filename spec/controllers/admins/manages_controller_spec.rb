require 'spec_helper'

describe Admins::ManagesController do
  render_views

  describe "#show" do
    context "authenticated user" do
      before do
        sign_in Factory(:admin)
      end

      it "should render the view" do
        get :show
        response.should be_success
      end

      context "existing conference config" do
        context "populate form" do
          it "should fill twitter handle" do
            config = { "twitter_handle" => "bluth_empires" }
            YAML.should_receive(:load_file).and_return(config)
            get :show

            doc = Nokogiri::HTML(response.body)
            doc.css("#conference_twitter_handle").attr("value").text.should == "bluth_empires"
          end

          it "should fill twitter hashtag" do
            config = { "twitter_hashtag" => "nerd" }
            YAML.should_receive(:load_file).and_return(config)
            get :show

            doc = Nokogiri::HTML(response.body)
            doc.css("#conference_twitter_hashtag").attr("value").text.should == "nerd"
          end

          it "should fill instagram client id" do
            config = { "instagram_client_id" => "pokemon" }
            YAML.should_receive(:load_file).and_return(config)
            get :show

            doc = Nokogiri::HTML(response.body)
            doc.css("#conference_instagram_client_id").attr("value").text.should == "pokemon"
          end

          it "should fill instagram hashtag " do
            config = { "instagram_hashtag" => "#ladygaga" }
            YAML.should_receive(:load_file).and_return(config)
            get :show

            doc = Nokogiri::HTML(response.body)
            doc.css("#conference_instagram_hashtag").attr("value").text.should == "#ladygaga"
          end

          it "should fill foursquare venue id" do
            config = { "foursquare_venue_id" => "12345" }
            YAML.should_receive(:load_file).and_return(config)
            get :show

            doc = Nokogiri::HTML(response.body)
            doc.css("#conference_foursquare_venue_id").attr("value").text.should == "12345"
          end

          it "should fill foursquare venue name" do
            config = { "foursquare_venue_name" => "pivotal labs" }
            YAML.should_receive(:load_file).and_return(config)
            get :show

            doc = Nokogiri::HTML(response.body)
            doc.css("#conference_foursquare_venue_name").attr("value").text.should == "pivotal labs"
          end

          it "should fill foursquare oauth token" do
            config = { "foursquare_oauth_token" => "authme" }
            YAML.should_receive(:load_file).and_return(config)
            get :show

            doc = Nokogiri::HTML(response.body)
            doc.css("#conference_foursquare_oauth_token").attr("value").text.should == "authme"
          end
        end
      end
    end

    context "unauthenticated user" do
      it "should redirect to the sign in view" do
        sign_out :admin
        get :show

        response.should redirect_to(:new_admin_session)
      end
    end
  end

  describe "#update" do
    context "authenticated user" do
      before do
        sign_in Factory(:admin)

        @params = {
          "twitter_handle" => "hello"
        }
      end

      it "should update the config" do
        file = double("file")
        File.stub(:open).and_yield(file)
        YAML.should_receive(:dump).with(@params, file)
        put :update, :conference => @params 

        response.should redirect_to(:manages)
      end
    end
  end
end
