require 'rails_helper'

RSpec.describe "Admin::PublicTransports", type: :request do
  describe "GET /admin_public_transports" do
    it "works! (now write some real specs)" do
      get admin_public_transports_path
      expect(response).to have_http_status(200)
    end
  end
end
