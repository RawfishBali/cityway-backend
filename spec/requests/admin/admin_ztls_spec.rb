require 'rails_helper'

RSpec.describe "Admin::Ztls", type: :request do
  describe "GET /admin_ztls" do
    it "works! (now write some real specs)" do
      get admin_ztls_path
      expect(response).to have_http_status(200)
    end
  end
end
