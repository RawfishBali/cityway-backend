require 'rails_helper'

RSpec.describe "admin/city_hall_stories/index", type: :view do
  before(:each) do
    assign(:admin_city_hall_stories, [
      Admin::CityHallStory.create!(),
      Admin::CityHallStory.create!()
    ])
  end

  it "renders a list of admin/city_hall_stories" do
    render
  end
end
