require 'rails_helper'

RSpec.describe "Admin::Places", type: :request do
  describe "GET /admin_places" do
    it "works! (now write some real specs)" do
      get admin_places_path
      expect(response).to have_http_status(200)
    end
  end
end
