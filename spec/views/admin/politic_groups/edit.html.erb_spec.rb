require 'rails_helper'

RSpec.describe "admin/politic_groups/edit", type: :view do
  before(:each) do
    @admin_politic_group = assign(:admin_politic_group, Admin::PoliticGroup.create!())
  end

  it "renders the edit admin_politic_group form" do
    render

    assert_select "form[action=?][method=?]", admin_politic_group_path(@admin_politic_group), "post" do
    end
  end
end
