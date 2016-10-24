require 'rails_helper'

RSpec.describe "admin/waste_types/index", type: :view do
  before(:each) do
    assign(:admin_waste_types, [
      Admin::WasteType.create!(),
      Admin::WasteType.create!()
    ])
  end

  it "renders a list of admin/waste_types" do
    render
  end
end
