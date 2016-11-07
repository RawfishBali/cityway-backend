require 'rails_helper'

RSpec.describe "admin/public_offices/index", type: :view do
  before(:each) do
    assign(:admin_public_offices, [
      Admin::PublicOffice.create!(),
      Admin::PublicOffice.create!()
    ])
  end

  it "renders a list of admin/public_offices" do
    render
  end
end
