require 'rails_helper'

RSpec.describe "Admin::Stories", type: :request do
  describe "GET /admin_stories" do
    it "works! (now write some real specs)" do
      get admin_stories_path
      expect(response).to have_http_status(200)
    end
  end
end
