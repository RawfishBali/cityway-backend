require 'rails_helper'

RSpec.describe "admin/utility_numbers/show", type: :view do
  before(:each) do
    @admin_utility_number = assign(:admin_utility_number, Admin::UtilityNumber.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
