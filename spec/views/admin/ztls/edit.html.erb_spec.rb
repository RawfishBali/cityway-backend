require 'rails_helper'

RSpec.describe "admin/ztls/edit", type: :view do
  before(:each) do
    @admin_ztl = assign(:admin_ztl, Admin::Ztl.create!())
  end

  it "renders the edit admin_ztl form" do
    render

    assert_select "form[action=?][method=?]", admin_ztl_path(@admin_ztl), "post" do
    end
  end
end
