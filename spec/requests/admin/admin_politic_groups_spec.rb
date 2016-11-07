require 'rails_helper'

RSpec.describe "Admin::PoliticGroups", type: :request do
  describe "GET /admin_politic_groups" do
    it "works! (now write some real specs)" do
      get admin_politic_groups_path
      expect(response).to have_http_status(200)
    end
  end
end
