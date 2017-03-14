require 'rails_helper'

RSpec.describe "admin/parking_lots/edit", type: :view do
  before(:each) do
    @admin_parking_lot = assign(:admin_parking_lot, Admin::ParkingLot.create!())
  end

  it "renders the edit admin_parking_lot form" do
    render

    assert_select "form[action=?][method=?]", admin_parking_lot_path(@admin_parking_lot), "post" do
    end
  end
end
