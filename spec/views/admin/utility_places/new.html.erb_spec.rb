require 'rails_helper'

RSpec.describe "admin/utility_places/new", type: :view do
  before(:each) do
    assign(:admin_utility_place, Admin::UtilityPlace.new())
  end

  it "renders new admin_utility_place form" do
    render

    assert_select "form[action=?][method=?]", admin_utility_places_path, "post" do
    end
  end
end
