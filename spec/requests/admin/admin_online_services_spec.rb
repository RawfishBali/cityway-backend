require 'rails_helper'

RSpec.describe "Admin::OnlineServices", type: :request do
  describe "GET /admin_online_services" do
    it "works! (now write some real specs)" do
      get admin_online_services_path
      expect(response).to have_http_status(200)
    end
  end
end
