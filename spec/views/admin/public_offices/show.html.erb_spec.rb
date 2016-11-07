require 'rails_helper'

RSpec.describe "admin/public_offices/show", type: :view do
  before(:each) do
    @admin_public_office = assign(:admin_public_office, Admin::PublicOffice.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
