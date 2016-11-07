require 'rails_helper'

RSpec.describe "admin/merchants/new", type: :view do
  before(:each) do
    assign(:admin_merchant, Admin::Merchant.new())
  end

  it "renders new admin_merchant form" do
    render

    assert_select "form[action=?][method=?]", admin_merchants_path, "post" do
    end
  end
end
