require 'rails_helper'

RSpec.describe "admin/merchants/edit", type: :view do
  before(:each) do
    @admin_merchant = assign(:admin_merchant, Admin::Merchant.create!())
  end

  it "renders the edit admin_merchant form" do
    render

    assert_select "form[action=?][method=?]", admin_merchant_path(@admin_merchant), "post" do
    end
  end
end
