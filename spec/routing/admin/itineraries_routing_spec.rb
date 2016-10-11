require "rails_helper"

RSpec.describe Admin::ItinerariesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/itineraries").to route_to("admin/itineraries#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/itineraries/new").to route_to("admin/itineraries#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/itineraries/1").to route_to("admin/itineraries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/itineraries/1/edit").to route_to("admin/itineraries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/itineraries").to route_to("admin/itineraries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/itineraries/1").to route_to("admin/itineraries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/itineraries/1").to route_to("admin/itineraries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/itineraries/1").to route_to("admin/itineraries#destroy", :id => "1")
    end

  end
end
