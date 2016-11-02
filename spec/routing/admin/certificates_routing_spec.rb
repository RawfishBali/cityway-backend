require "rails_helper"

RSpec.describe Admin::CertificatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/certificates").to route_to("admin/certificates#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/certificates/new").to route_to("admin/certificates#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/certificates/1").to route_to("admin/certificates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/certificates/1/edit").to route_to("admin/certificates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/certificates").to route_to("admin/certificates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/certificates/1").to route_to("admin/certificates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/certificates/1").to route_to("admin/certificates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/certificates/1").to route_to("admin/certificates#destroy", :id => "1")
    end

  end
end
