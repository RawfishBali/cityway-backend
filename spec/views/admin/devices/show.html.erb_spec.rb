require 'rails_helper'

RSpec.describe "admin/devices/show", type: :view do
  before(:each) do
    @admin_device = assign(:admin_device, Admin::Device.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
