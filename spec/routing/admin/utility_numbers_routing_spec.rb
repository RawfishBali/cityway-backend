require "rails_helper"

RSpec.describe Admin::UtilityNumbersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/utility_numbers").to route_to("admin/utility_numbers#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/utility_numbers/new").to route_to("admin/utility_numbers#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/utility_numbers/1").to route_to("admin/utility_numbers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/utility_numbers/1/edit").to route_to("admin/utility_numbers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/utility_numbers").to route_to("admin/utility_numbers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/utility_numbers/1").to route_to("admin/utility_numbers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/utility_numbers/1").to route_to("admin/utility_numbers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/utility_numbers/1").to route_to("admin/utility_numbers#destroy", :id => "1")
    end

  end
end
