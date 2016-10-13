require 'rails_helper'

RSpec.describe "Admin::Securities", type: :request do
  describe "GET /admin_securities" do
    it "works! (now write some real specs)" do
      get admin_securities_path
      expect(response).to have_http_status(200)
    end
  end
end
