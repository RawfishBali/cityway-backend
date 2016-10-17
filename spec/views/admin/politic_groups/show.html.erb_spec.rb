require 'rails_helper'

RSpec.describe "admin/politic_groups/show", type: :view do
  before(:each) do
    @admin_politic_group = assign(:admin_politic_group, Admin::PoliticGroup.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
