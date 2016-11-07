require 'rails_helper'

RSpec.describe "admin/city_hall_stories/new", type: :view do
  before(:each) do
    assign(:admin_city_hall_story, Admin::CityHallStory.new())
  end

  it "renders new admin_city_hall_story form" do
    render

    assert_select "form[action=?][method=?]", admin_city_hall_stories_path, "post" do
    end
  end
end
