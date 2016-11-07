require 'rails_helper'

RSpec.describe "admin/public_offices/edit", type: :view do
  before(:each) do
    @admin_public_office = assign(:admin_public_office, Admin::PublicOffice.create!())
  end

  it "renders the edit admin_public_office form" do
    render

    assert_select "form[action=?][method=?]", admin_public_office_path(@admin_public_office), "post" do
    end
  end
end
