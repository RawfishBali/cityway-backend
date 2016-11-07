require 'rails_helper'

RSpec.describe "admin/devices/index", type: :view do
  before(:each) do
    assign(:admin_devices, [
      Admin::Device.create!(),
      Admin::Device.create!()
    ])
  end

  it "renders a list of admin/devices" do
    render
  end
end
