require "rails_helper"

RSpec.describe Admin::PoliticGroupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/politic_groups").to route_to("admin/politic_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/politic_groups/new").to route_to("admin/politic_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/politic_groups/1").to route_to("admin/politic_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/politic_groups/1/edit").to route_to("admin/politic_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/politic_groups").to route_to("admin/politic_groups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/politic_groups/1").to route_to("admin/politic_groups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/politic_groups/1").to route_to("admin/politic_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/politic_groups/1").to route_to("admin/politic_groups#destroy", :id => "1")
    end

  end
end
