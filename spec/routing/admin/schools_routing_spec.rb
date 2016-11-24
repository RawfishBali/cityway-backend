require "rails_helper"

RSpec.describe Admin::SchoolsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/schools").to route_to("admin/schools#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/schools/new").to route_to("admin/schools#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/schools/1").to route_to("admin/schools#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/schools/1/edit").to route_to("admin/schools#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/schools").to route_to("admin/schools#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/schools/1").to route_to("admin/schools#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/schools/1").to route_to("admin/schools#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/schools/1").to route_to("admin/schools#destroy", :id => "1")
    end

  end
end
