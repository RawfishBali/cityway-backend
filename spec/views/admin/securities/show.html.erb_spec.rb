require 'rails_helper'

RSpec.describe "admin/securities/show", type: :view do
  before(:each) do
    @admin_security = assign(:admin_security, Admin::Security.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
