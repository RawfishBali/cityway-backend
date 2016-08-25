require "rails_helper"

RSpec.describe Admin::MerchantsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/merchants").to route_to("admin/merchants#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/merchants/new").to route_to("admin/merchants#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/merchants/1").to route_to("admin/merchants#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/merchants/1/edit").to route_to("admin/merchants#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/merchants").to route_to("admin/merchants#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/merchants/1").to route_to("admin/merchants#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/merchants/1").to route_to("admin/merchants#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/merchants/1").to route_to("admin/merchants#destroy", :id => "1")
    end

  end
end
