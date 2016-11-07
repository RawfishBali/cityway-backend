require "rails_helper"

RSpec.describe Admin::WasteManagementsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/waste_managements").to route_to("admin/waste_managements#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/waste_managements/new").to route_to("admin/waste_managements#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/waste_managements/1").to route_to("admin/waste_managements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/waste_managements/1/edit").to route_to("admin/waste_managements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/waste_managements").to route_to("admin/waste_managements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/waste_managements/1").to route_to("admin/waste_managements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/waste_managements/1").to route_to("admin/waste_managements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/waste_managements/1").to route_to("admin/waste_managements#destroy", :id => "1")
    end

  end
end
