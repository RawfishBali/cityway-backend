require 'rails_helper'

RSpec.describe "admin/waste_managements/index", type: :view do
  before(:each) do
    assign(:admin_waste_managements, [
      Admin::WasteManagement.create!(),
      Admin::WasteManagement.create!()
    ])
  end

  it "renders a list of admin/waste_managements" do
    render
  end
end
