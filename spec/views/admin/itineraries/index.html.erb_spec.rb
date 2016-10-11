require 'rails_helper'

RSpec.describe "admin/itineraries/index", type: :view do
  before(:each) do
    assign(:admin_itineraries, [
      Admin::Itinerary.create!(),
      Admin::Itinerary.create!()
    ])
  end

  it "renders a list of admin/itineraries" do
    render
  end
end
