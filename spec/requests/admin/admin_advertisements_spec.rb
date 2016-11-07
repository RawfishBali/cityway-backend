require 'rails_helper'

RSpec.describe "Admin::Advertisements", type: :request do
  describe "GET /admin_advertisements" do
    it "works! (now write some real specs)" do
      get admin_advertisements_path
      expect(response).to have_http_status(200)
    end
  end
end
