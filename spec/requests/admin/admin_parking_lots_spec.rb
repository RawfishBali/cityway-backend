require 'rails_helper'

RSpec.describe "Admin::ParkingLots", type: :request do
  describe "GET /admin_parking_lots" do
    it "works! (now write some real specs)" do
      get admin_parking_lots_path
      expect(response).to have_http_status(200)
    end
  end
end
