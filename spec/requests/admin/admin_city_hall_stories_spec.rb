require 'rails_helper'

RSpec.describe "Admin::CityHallStories", type: :request do
  describe "GET /admin_city_hall_stories" do
    it "works! (now write some real specs)" do
      get admin_city_hall_stories_path
      expect(response).to have_http_status(200)
    end
  end
end
