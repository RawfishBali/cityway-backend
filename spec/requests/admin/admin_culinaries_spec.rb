require 'rails_helper'

RSpec.describe "Admin::Culinaries", type: :request do
  describe "GET /admin_culinaries" do
    it "works! (now write some real specs)" do
      get admin_culinaries_path
      expect(response).to have_http_status(200)
    end
  end
end
