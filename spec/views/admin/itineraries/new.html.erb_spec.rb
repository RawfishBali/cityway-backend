require 'rails_helper'

RSpec.describe "admin/itineraries/new", type: :view do
  before(:each) do
    assign(:admin_itinerary, Admin::Itinerary.new())
  end

  it "renders new admin_itinerary form" do
    render

    assert_select "form[action=?][method=?]", admin_itineraries_path, "post" do
    end
  end
end
