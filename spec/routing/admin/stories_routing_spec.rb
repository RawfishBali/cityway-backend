require "rails_helper"

RSpec.describe Admin::StoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/stories").to route_to("admin/stories#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/stories/new").to route_to("admin/stories#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/stories/1").to route_to("admin/stories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/stories/1/edit").to route_to("admin/stories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/stories").to route_to("admin/stories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/stories/1").to route_to("admin/stories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/stories/1").to route_to("admin/stories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/stories/1").to route_to("admin/stories#destroy", :id => "1")
    end

  end
end
