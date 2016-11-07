require 'rails_helper'

RSpec.describe "Admin::Vehicles", type: :request do
  describe "GET /admin_vehicles" do
    it "works! (now write some real specs)" do
      get admin_vehicles_path
      expect(response).to have_http_status(200)
    end
  end
end
