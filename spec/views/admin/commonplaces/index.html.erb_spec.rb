require 'rails_helper'

RSpec.describe "admin/commonplaces/index", type: :view do
  before(:each) do
    assign(:admin_commonplaces, [
      Admin::Commonplace.create!(),
      Admin::Commonplace.create!()
    ])
  end

  it "renders a list of admin/commonplaces" do
    render
  end
end
