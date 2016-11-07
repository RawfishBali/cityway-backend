require 'rails_helper'

RSpec.describe "admin/waste_managements/new", type: :view do
  before(:each) do
    assign(:admin_waste_management, Admin::WasteManagement.new())
  end

  it "renders new admin_waste_management form" do
    render

    assert_select "form[action=?][method=?]", admin_waste_managements_path, "post" do
    end
  end
end
