require 'rails_helper'

RSpec.describe "admin/markets/edit", type: :view do
  before(:each) do
    @admin_market = assign(:admin_market, Admin::Market.create!())
  end

  it "renders the edit admin_market form" do
    render

    assert_select "form[action=?][method=?]", admin_market_path(@admin_market), "post" do
    end
  end
end
