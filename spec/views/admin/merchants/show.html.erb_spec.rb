require 'rails_helper'

RSpec.describe "admin/merchants/show", type: :view do
  before(:each) do
    @admin_merchant = assign(:admin_merchant, Admin::Merchant.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
