require 'rails_helper'

RSpec.describe "admin/utility_places/show", type: :view do
  before(:each) do
    @admin_utility_place = assign(:admin_utility_place, Admin::UtilityPlace.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
