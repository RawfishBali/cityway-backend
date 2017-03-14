require "rails_helper"

RSpec.describe Admin::SportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/sports").to route_to("admin/sports#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/sports/new").to route_to("admin/sports#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/sports/1").to route_to("admin/sports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/sports/1/edit").to route_to("admin/sports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/sports").to route_to("admin/sports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/sports/1").to route_to("admin/sports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/sports/1").to route_to("admin/sports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/sports/1").to route_to("admin/sports#destroy", :id => "1")
    end

  end
end
