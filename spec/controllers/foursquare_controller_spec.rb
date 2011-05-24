require 'spec_helper'

describe FoursquareController do
  render_views

  before do
    @avatar = {"user" => {'photo' => "avatar.jpg" }}
    @fsq_client = double()
    HTTPClient.stub(:new) { @fsq_client }
  end

  it "should render 10 avatars with css class normal" do
    ten_avatars = Array.new(10, @avatar)
    avatars_j = {'response' => {'hereNow' => {'items' => ten_avatars}}}.to_json 
    @fsq_client.stub(:get_content).and_return(avatars_j)

    get :index

    doc = Nokogiri::HTML(response.body)
    doc.css("img.normal").size.should == 10
  end
  
  it "should render 10 avatars with css class normal" do
    twenty_avatars = Array.new(20, @avatar)
    avatars_j = {'response' => {'hereNow' => {'items' => twenty_avatars}}}.to_json 
    @fsq_client.stub(:get_content).and_return(avatars_j)

    get :index

    doc = Nokogiri::HTML(response.body)
    doc.css("img.small").size.should == 20
  end
  
  it "should render 10 avatars with css class normal" do
    thirty_avatars = Array.new(30, @avatar)
    avatars_j = {'response' => {'hereNow' => {'items' => thirty_avatars}}}.to_json 
    @fsq_client.stub(:get_content).and_return(avatars_j)

    get :index

    doc = Nokogiri::HTML(response.body)
    doc.css("img.tiny").size.should == 30
  end
end
