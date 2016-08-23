require "rails_helper"

RSpec.describe Admin::AdvertisementsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/advertisements").to route_to("admin/advertisements#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/advertisements/new").to route_to("admin/advertisements#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/advertisements/1").to route_to("admin/advertisements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/advertisements/1/edit").to route_to("admin/advertisements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/advertisements").to route_to("admin/advertisements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/advertisements/1").to route_to("admin/advertisements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/advertisements/1").to route_to("admin/advertisements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/advertisements/1").to route_to("admin/advertisements#destroy", :id => "1")
    end

  end
end
