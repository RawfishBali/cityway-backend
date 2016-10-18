require "rails_helper"

RSpec.describe Admin::DevicesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/devices").to route_to("admin/devices#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/devices/new").to route_to("admin/devices#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/devices/1").to route_to("admin/devices#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/devices/1/edit").to route_to("admin/devices#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/devices").to route_to("admin/devices#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/devices/1").to route_to("admin/devices#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/devices/1").to route_to("admin/devices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/devices/1").to route_to("admin/devices#destroy", :id => "1")
    end

  end
end
