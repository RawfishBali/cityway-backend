require 'rails_helper'

RSpec.describe "admin/waste_managements/show", type: :view do
  before(:each) do
    @admin_waste_management = assign(:admin_waste_management, Admin::WasteManagement.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
