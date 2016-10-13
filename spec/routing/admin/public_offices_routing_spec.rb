require "rails_helper"

RSpec.describe Admin::PublicOfficesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/public_offices").to route_to("admin/public_offices#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/public_offices/new").to route_to("admin/public_offices#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/public_offices/1").to route_to("admin/public_offices#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/public_offices/1/edit").to route_to("admin/public_offices#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/public_offices").to route_to("admin/public_offices#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/public_offices/1").to route_to("admin/public_offices#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/public_offices/1").to route_to("admin/public_offices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/public_offices/1").to route_to("admin/public_offices#destroy", :id => "1")
    end

  end
end
