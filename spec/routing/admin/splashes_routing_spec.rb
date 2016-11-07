require "rails_helper"

RSpec.describe Admin::SplashesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/splashes").to route_to("admin/splashes#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/splashes/new").to route_to("admin/splashes#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/splashes/1").to route_to("admin/splashes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/splashes/1/edit").to route_to("admin/splashes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/splashes").to route_to("admin/splashes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/splashes/1").to route_to("admin/splashes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/splashes/1").to route_to("admin/splashes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/splashes/1").to route_to("admin/splashes#destroy", :id => "1")
    end

  end
end
