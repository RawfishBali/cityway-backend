require 'rails_helper'

RSpec.describe "admin/itineraries/show", type: :view do
  before(:each) do
    @admin_itinerary = assign(:admin_itinerary, Admin::Itinerary.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
