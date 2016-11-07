require 'rails_helper'

RSpec.describe "Admin::Parks", type: :request do
  describe "GET /admin_parks" do
    it "works! (now write some real specs)" do
      get admin_parks_path
      expect(response).to have_http_status(200)
    end
  end
end
