require 'rails_helper'

RSpec.describe "Admin::PublicOffices", type: :request do
  describe "GET /admin_public_offices" do
    it "works! (now write some real specs)" do
      get admin_public_offices_path
      expect(response).to have_http_status(200)
    end
  end
end
