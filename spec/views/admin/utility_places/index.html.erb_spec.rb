require 'rails_helper'

RSpec.describe "admin/utility_places/index", type: :view do
  before(:each) do
    assign(:admin_utility_places, [
      Admin::UtilityPlace.create!(),
      Admin::UtilityPlace.create!()
    ])
  end

  it "renders a list of admin/utility_places" do
    render
  end
end
