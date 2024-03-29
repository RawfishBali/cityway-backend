require 'rails_helper'

RSpec.describe "admin/securities/edit", type: :view do
  before(:each) do
    @admin_security = assign(:admin_security, Admin::Security.create!())
  end

  it "renders the edit admin_security form" do
    render

    assert_select "form[action=?][method=?]", admin_security_path(@admin_security), "post" do
    end
  end
end
