require 'rails_helper'

RSpec.describe "admin/public_offices/new", type: :view do
  before(:each) do
    assign(:admin_public_office, Admin::PublicOffice.new())
  end

  it "renders new admin_public_office form" do
    render

    assert_select "form[action=?][method=?]", admin_public_offices_path, "post" do
    end
  end
end
