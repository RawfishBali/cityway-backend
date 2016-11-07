require 'rails_helper'

RSpec.describe "Admin::UtilityNumbers", type: :request do
  describe "GET /admin_utility_numbers" do
    it "works! (now write some real specs)" do
      get admin_utility_numbers_path
      expect(response).to have_http_status(200)
    end
  end
end
