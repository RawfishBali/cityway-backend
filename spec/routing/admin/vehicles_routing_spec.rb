require "rails_helper"

RSpec.describe Admin::VehiclesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/vehicles").to route_to("admin/vehicles#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/vehicles/new").to route_to("admin/vehicles#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/vehicles/1").to route_to("admin/vehicles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/vehicles/1/edit").to route_to("admin/vehicles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/vehicles").to route_to("admin/vehicles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/vehicles/1").to route_to("admin/vehicles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/vehicles/1").to route_to("admin/vehicles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/vehicles/1").to route_to("admin/vehicles#destroy", :id => "1")
    end

  end
end
