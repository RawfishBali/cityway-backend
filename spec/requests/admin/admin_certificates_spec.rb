require 'rails_helper'

RSpec.describe "Admin::Certificates", type: :request do
  describe "GET /admin_certificates" do
    it "works! (now write some real specs)" do
      get admin_certificates_path
      expect(response).to have_http_status(200)
    end
  end
end
