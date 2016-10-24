require 'rails_helper'

RSpec.describe "admin/waste_types/show", type: :view do
  before(:each) do
    @admin_waste_type = assign(:admin_waste_type, Admin::WasteType.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
