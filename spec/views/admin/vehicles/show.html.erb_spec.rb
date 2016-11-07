require 'rails_helper'

RSpec.describe "admin/vehicles/show", type: :view do
  before(:each) do
    @admin_vehicle = assign(:admin_vehicle, Admin::Vehicle.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
