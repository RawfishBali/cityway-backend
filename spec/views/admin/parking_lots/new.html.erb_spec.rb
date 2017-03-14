require 'rails_helper'

RSpec.describe "admin/parking_lots/new", type: :view do
  before(:each) do
    assign(:admin_parking_lot, Admin::ParkingLot.new())
  end

  it "renders new admin_parking_lot form" do
    render

    assert_select "form[action=?][method=?]", admin_parking_lots_path, "post" do
    end
  end
end
