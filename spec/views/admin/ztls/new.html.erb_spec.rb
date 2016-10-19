require 'rails_helper'

RSpec.describe "admin/ztls/new", type: :view do
  before(:each) do
    assign(:admin_ztl, Admin::Ztl.new())
  end

  it "renders new admin_ztl form" do
    render

    assert_select "form[action=?][method=?]", admin_ztls_path, "post" do
    end
  end
end
