require "rails_helper"

RSpec.describe Admin::OnlineServicesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/online_services").to route_to("admin/online_services#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/online_services/new").to route_to("admin/online_services#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/online_services/1").to route_to("admin/online_services#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/online_services/1/edit").to route_to("admin/online_services#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/online_services").to route_to("admin/online_services#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/online_services/1").to route_to("admin/online_services#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/online_services/1").to route_to("admin/online_services#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/online_services/1").to route_to("admin/online_services#destroy", :id => "1")
    end

  end
end
