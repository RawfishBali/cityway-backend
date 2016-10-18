require 'rails_helper'

RSpec.describe "admin/utility_places/edit", type: :view do
  before(:each) do
    @admin_utility_place = assign(:admin_utility_place, Admin::UtilityPlace.create!())
  end

  it "renders the edit admin_utility_place form" do
    render

    assert_select "form[action=?][method=?]", admin_utility_place_path(@admin_utility_place), "post" do
    end
  end
end
