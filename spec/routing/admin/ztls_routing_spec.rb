require "rails_helper"

RSpec.describe Admin::ZtlsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/ztls").to route_to("admin/ztls#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/ztls/new").to route_to("admin/ztls#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/ztls/1").to route_to("admin/ztls#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/ztls/1/edit").to route_to("admin/ztls#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/ztls").to route_to("admin/ztls#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/ztls/1").to route_to("admin/ztls#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/ztls/1").to route_to("admin/ztls#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/ztls/1").to route_to("admin/ztls#destroy", :id => "1")
    end

  end
end
