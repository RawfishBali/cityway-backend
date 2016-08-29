require "rails_helper"

RSpec.describe Admin::PromosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/promos").to route_to("admin/promos#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/promos/new").to route_to("admin/promos#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/promos/1").to route_to("admin/promos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/promos/1/edit").to route_to("admin/promos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/promos").to route_to("admin/promos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/promos/1").to route_to("admin/promos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/promos/1").to route_to("admin/promos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/promos/1").to route_to("admin/promos#destroy", :id => "1")
    end

  end
end
