require "rails_helper"

RSpec.describe Admin::CulinariesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/culinaries").to route_to("admin/culinaries#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/culinaries/new").to route_to("admin/culinaries#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/culinaries/1").to route_to("admin/culinaries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/culinaries/1/edit").to route_to("admin/culinaries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/culinaries").to route_to("admin/culinaries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/culinaries/1").to route_to("admin/culinaries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/culinaries/1").to route_to("admin/culinaries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/culinaries/1").to route_to("admin/culinaries#destroy", :id => "1")
    end

  end
end
