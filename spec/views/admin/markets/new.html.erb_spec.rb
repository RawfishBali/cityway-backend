require 'rails_helper'

RSpec.describe "admin/markets/new", type: :view do
  before(:each) do
    assign(:admin_market, Admin::Market.new())
  end

  it "renders new admin_market form" do
    render

    assert_select "form[action=?][method=?]", admin_markets_path, "post" do
    end
  end
end
