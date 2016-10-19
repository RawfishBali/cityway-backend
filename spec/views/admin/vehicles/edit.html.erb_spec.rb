require 'rails_helper'

RSpec.describe "admin/vehicles/edit", type: :view do
  before(:each) do
    @admin_vehicle = assign(:admin_vehicle, Admin::Vehicle.create!())
  end

  it "renders the edit admin_vehicle form" do
    render

    assert_select "form[action=?][method=?]", admin_vehicle_path(@admin_vehicle), "post" do
    end
  end
end
