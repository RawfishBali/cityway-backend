require 'rails_helper'

RSpec.describe "admin/utility_numbers/index", type: :view do
  before(:each) do
    assign(:admin_utility_numbers, [
      Admin::UtilityNumber.create!(),
      Admin::UtilityNumber.create!()
    ])
  end

  it "renders a list of admin/utility_numbers" do
    render
  end
end
