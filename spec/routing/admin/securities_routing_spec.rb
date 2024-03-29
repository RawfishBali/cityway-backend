require "rails_helper"

RSpec.describe Admin::SecuritiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/securities").to route_to("admin/securities#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/securities/new").to route_to("admin/securities#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/securities/1").to route_to("admin/securities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/securities/1/edit").to route_to("admin/securities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/securities").to route_to("admin/securities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/securities/1").to route_to("admin/securities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/securities/1").to route_to("admin/securities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/securities/1").to route_to("admin/securities#destroy", :id => "1")
    end

  end
end
