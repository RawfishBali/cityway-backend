require 'rails_helper'

RSpec.describe "admin/waste_managements/edit", type: :view do
  before(:each) do
    @admin_waste_management = assign(:admin_waste_management, Admin::WasteManagement.create!())
  end

  it "renders the edit admin_waste_management form" do
    render

    assert_select "form[action=?][method=?]", admin_waste_management_path(@admin_waste_management), "post" do
    end
  end
end
