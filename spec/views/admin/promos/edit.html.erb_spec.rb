require 'rails_helper'

RSpec.describe "admin/promos/edit", type: :view do
  before(:each) do
    @admin_promo = assign(:admin_promo, Admin::Promo.create!())
  end

  it "renders the edit admin_promo form" do
    render

    assert_select "form[action=?][method=?]", admin_promo_path(@admin_promo), "post" do
    end
  end
end
