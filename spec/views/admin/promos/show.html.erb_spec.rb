require 'rails_helper'

RSpec.describe "admin/promos/show", type: :view do
  before(:each) do
    @admin_promo = assign(:admin_promo, Admin::Promo.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
