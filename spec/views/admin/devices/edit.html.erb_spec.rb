require 'rails_helper'

RSpec.describe "admin/devices/edit", type: :view do
  before(:each) do
    @admin_device = assign(:admin_device, Admin::Device.create!())
  end

  it "renders the edit admin_device form" do
    render

    assert_select "form[action=?][method=?]", admin_device_path(@admin_device), "post" do
    end
  end
end
