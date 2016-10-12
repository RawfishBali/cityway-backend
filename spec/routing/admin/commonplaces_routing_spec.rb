require "rails_helper"

RSpec.describe Admin::CommonplacesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/commonplaces").to route_to("admin/commonplaces#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/commonplaces/new").to route_to("admin/commonplaces#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/commonplaces/1").to route_to("admin/commonplaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/commonplaces/1/edit").to route_to("admin/commonplaces#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/commonplaces").to route_to("admin/commonplaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/commonplaces/1").to route_to("admin/commonplaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/commonplaces/1").to route_to("admin/commonplaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/commonplaces/1").to route_to("admin/commonplaces#destroy", :id => "1")
    end

  end
end
