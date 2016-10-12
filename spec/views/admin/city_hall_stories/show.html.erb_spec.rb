require 'rails_helper'

RSpec.describe "admin/city_hall_stories/show", type: :view do
  before(:each) do
    @admin_city_hall_story = assign(:admin_city_hall_story, Admin::CityHallStory.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
