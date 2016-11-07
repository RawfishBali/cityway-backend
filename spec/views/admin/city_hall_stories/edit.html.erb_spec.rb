require 'rails_helper'

RSpec.describe "admin/city_hall_stories/edit", type: :view do
  before(:each) do
    @admin_city_hall_story = assign(:admin_city_hall_story, Admin::CityHallStory.create!())
  end

  it "renders the edit admin_city_hall_story form" do
    render

    assert_select "form[action=?][method=?]", admin_city_hall_story_path(@admin_city_hall_story), "post" do
    end
  end
end
