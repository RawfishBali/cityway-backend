require 'rails_helper'

RSpec.describe "Admin::WasteManagements", type: :request do
  describe "GET /admin_waste_managements" do
    it "works! (now write some real specs)" do
      get admin_waste_managements_path
      expect(response).to have_http_status(200)
    end
  end
end
