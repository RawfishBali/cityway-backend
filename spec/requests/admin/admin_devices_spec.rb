require 'rails_helper'

RSpec.describe "Admin::Devices", type: :request do
  describe "GET /admin_devices" do
    it "works! (now write some real specs)" do
      get admin_devices_path
      expect(response).to have_http_status(200)
    end
  end
end
