require 'rails_helper'

RSpec.describe "Admin::Promos", type: :request do
  describe "GET /admin_promos" do
    it "works! (now write some real specs)" do
      get admin_promos_path
      expect(response).to have_http_status(200)
    end
  end
end
