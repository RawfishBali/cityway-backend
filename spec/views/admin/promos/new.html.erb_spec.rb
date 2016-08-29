require 'rails_helper'

RSpec.describe "admin/promos/new", type: :view do
  before(:each) do
    assign(:admin_promo, Admin::Promo.new())
  end

  it "renders new admin_promo form" do
    render

    assert_select "form[action=?][method=?]", admin_promos_path, "post" do
    end
  end
end
