require 'rails_helper'

RSpec.describe "admin/utility_numbers/edit", type: :view do
  before(:each) do
    @admin_utility_number = assign(:admin_utility_number, Admin::UtilityNumber.create!())
  end

  it "renders the edit admin_utility_number form" do
    render

    assert_select "form[action=?][method=?]", admin_utility_number_path(@admin_utility_number), "post" do
    end
  end
end
