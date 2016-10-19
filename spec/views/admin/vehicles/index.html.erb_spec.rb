require 'rails_helper'

RSpec.describe "admin/vehicles/index", type: :view do
  before(:each) do
    assign(:admin_vehicles, [
      Admin::Vehicle.create!(),
      Admin::Vehicle.create!()
    ])
  end

  it "renders a list of admin/vehicles" do
    render
  end
end
