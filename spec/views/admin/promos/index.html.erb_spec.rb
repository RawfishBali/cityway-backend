require 'rails_helper'

RSpec.describe "admin/promos/index", type: :view do
  before(:each) do
    assign(:admin_promos, [
      Admin::Promo.create!(),
      Admin::Promo.create!()
    ])
  end

  it "renders a list of admin/promos" do
    render
  end
end
