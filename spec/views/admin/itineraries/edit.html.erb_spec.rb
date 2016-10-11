require 'rails_helper'

RSpec.describe "admin/itineraries/edit", type: :view do
  before(:each) do
    @admin_itinerary = assign(:admin_itinerary, Admin::Itinerary.create!())
  end

  it "renders the edit admin_itinerary form" do
    render

    assert_select "form[action=?][method=?]", admin_itinerary_path(@admin_itinerary), "post" do
    end
  end
end
