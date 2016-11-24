require 'rails_helper'

RSpec.describe "Admin::Sports", type: :request do
  describe "GET /admin_sports" do
    it "works! (now write some real specs)" do
      get admin_sports_path
      expect(response).to have_http_status(200)
    end
  end
end
