require 'rails_helper'

RSpec.describe "admin/waste_types/new", type: :view do
  before(:each) do
    assign(:admin_waste_type, Admin::WasteType.new())
  end

  it "renders new admin_waste_type form" do
    render

    assert_select "form[action=?][method=?]", admin_waste_types_path, "post" do
    end
  end
end
