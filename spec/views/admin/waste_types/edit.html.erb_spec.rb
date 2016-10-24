require 'rails_helper'

RSpec.describe "admin/waste_types/edit", type: :view do
  before(:each) do
    @admin_waste_type = assign(:admin_waste_type, Admin::WasteType.create!())
  end

  it "renders the edit admin_waste_type form" do
    render

    assert_select "form[action=?][method=?]", admin_waste_type_path(@admin_waste_type), "post" do
    end
  end
end
