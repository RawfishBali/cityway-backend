require 'rails_helper'

RSpec.describe "admin/securities/new", type: :view do
  before(:each) do
    assign(:admin_security, Admin::Security.new())
  end

  it "renders new admin_security form" do
    render

    assert_select "form[action=?][method=?]", admin_securities_path, "post" do
    end
  end
end
