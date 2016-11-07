require 'rails_helper'

RSpec.describe "admin/commonplaces/new", type: :view do
  before(:each) do
    assign(:admin_commonplace, Admin::Commonplace.new())
  end

  it "renders new admin_commonplace form" do
    render

    assert_select "form[action=?][method=?]", admin_commonplaces_path, "post" do
    end
  end
end
