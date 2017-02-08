require 'rails_helper'

RSpec.describe "admin/parking_lots/show", type: :view do
  before(:each) do
    @admin_parking_lot = assign(:admin_parking_lot, Admin::ParkingLot.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
