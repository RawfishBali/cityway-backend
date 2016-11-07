require 'rails_helper'

RSpec.describe "admin/politic_groups/new", type: :view do
  before(:each) do
    assign(:admin_politic_group, Admin::PoliticGroup.new())
  end

  it "renders new admin_politic_group form" do
    render

    assert_select "form[action=?][method=?]", admin_politic_groups_path, "post" do
    end
  end
end
