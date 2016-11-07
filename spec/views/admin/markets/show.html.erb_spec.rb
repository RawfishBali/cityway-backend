require 'rails_helper'

RSpec.describe "admin/markets/show", type: :view do
  before(:each) do
    @admin_market = assign(:admin_market, Admin::Market.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
