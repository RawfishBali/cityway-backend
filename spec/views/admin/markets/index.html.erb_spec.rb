require 'rails_helper'

RSpec.describe "admin/markets/index", type: :view do
  before(:each) do
    assign(:admin_markets, [
      Admin::Market.create!(),
      Admin::Market.create!()
    ])
  end

  it "renders a list of admin/markets" do
    render
  end
end
