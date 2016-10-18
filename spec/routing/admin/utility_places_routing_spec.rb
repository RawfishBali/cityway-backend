require "rails_helper"

RSpec.describe Admin::UtilityPlacesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/utility_places").to route_to("admin/utility_places#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/utility_places/new").to route_to("admin/utility_places#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/utility_places/1").to route_to("admin/utility_places#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/utility_places/1/edit").to route_to("admin/utility_places#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/utility_places").to route_to("admin/utility_places#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/utility_places/1").to route_to("admin/utility_places#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/utility_places/1").to route_to("admin/utility_places#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/utility_places/1").to route_to("admin/utility_places#destroy", :id => "1")
    end

  end
end
