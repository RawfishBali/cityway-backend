require 'rails_helper'

RSpec.describe "admin/merchants/index", type: :view do
  before(:each) do
    assign(:admin_merchants, [
      Admin::Merchant.create!(),
      Admin::Merchant.create!()
    ])
  end

  it "renders a list of admin/merchants" do
    render
  end
end
