require "rails_helper"

RSpec.describe Admin::CityHallStoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/city_hall_stories").to route_to("admin/city_hall_stories#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/city_hall_stories/new").to route_to("admin/city_hall_stories#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/city_hall_stories/1").to route_to("admin/city_hall_stories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/city_hall_stories/1/edit").to route_to("admin/city_hall_stories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/city_hall_stories").to route_to("admin/city_hall_stories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/city_hall_stories/1").to route_to("admin/city_hall_stories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/city_hall_stories/1").to route_to("admin/city_hall_stories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/city_hall_stories/1").to route_to("admin/city_hall_stories#destroy", :id => "1")
    end

  end
end
