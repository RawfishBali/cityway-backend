require 'rails_helper'

RSpec.describe "admin/utility_numbers/new", type: :view do
  before(:each) do
    assign(:admin_utility_number, Admin::UtilityNumber.new())
  end

  it "renders new admin_utility_number form" do
    render

    assert_select "form[action=?][method=?]", admin_utility_numbers_path, "post" do
    end
  end
end
