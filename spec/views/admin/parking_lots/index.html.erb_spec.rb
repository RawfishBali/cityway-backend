require 'rails_helper'

RSpec.describe "admin/parking_lots/index", type: :view do
  before(:each) do
    assign(:admin_parking_lots, [
      Admin::ParkingLot.create!(),
      Admin::ParkingLot.create!()
    ])
  end

  it "renders a list of admin/parking_lots" do
    render
  end
end
