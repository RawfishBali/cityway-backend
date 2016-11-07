require "rails_helper"

RSpec.describe Admin::PublicTransportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/public_transports").to route_to("admin/public_transports#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/public_transports/new").to route_to("admin/public_transports#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/public_transports/1").to route_to("admin/public_transports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/public_transports/1/edit").to route_to("admin/public_transports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/public_transports").to route_to("admin/public_transports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/public_transports/1").to route_to("admin/public_transports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/public_transports/1").to route_to("admin/public_transports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/public_transports/1").to route_to("admin/public_transports#destroy", :id => "1")
    end

  end
end
