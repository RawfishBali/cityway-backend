require 'rails_helper'

RSpec.describe "admin/politic_groups/index", type: :view do
  before(:each) do
    assign(:admin_politic_groups, [
      Admin::PoliticGroup.create!(),
      Admin::PoliticGroup.create!()
    ])
  end

  it "renders a list of admin/politic_groups" do
    render
  end
end
