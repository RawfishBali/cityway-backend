require 'rails_helper'

RSpec.describe "admin/vehicles/new", type: :view do
  before(:each) do
    assign(:admin_vehicle, Admin::Vehicle.new())
  end

  it "renders new admin_vehicle form" do
    render

    assert_select "form[action=?][method=?]", admin_vehicles_path, "post" do
    end
  end
end
