require 'rails_helper'

RSpec.describe "admin/devices/new", type: :view do
  before(:each) do
    assign(:admin_device, Admin::Device.new())
  end

  it "renders new admin_device form" do
    render

    assert_select "form[action=?][method=?]", admin_devices_path, "post" do
    end
  end
end
