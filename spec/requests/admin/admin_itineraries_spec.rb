require 'rails_helper'

RSpec.describe "Admin::Itineraries", type: :request do
  describe "GET /admin_itineraries" do
    it "works! (now write some real specs)" do
      get admin_itineraries_path
      expect(response).to have_http_status(200)
    end
  end
end
