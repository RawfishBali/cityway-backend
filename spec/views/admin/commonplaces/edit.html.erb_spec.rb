require 'rails_helper'

RSpec.describe "admin/commonplaces/edit", type: :view do
  before(:each) do
    @admin_commonplace = assign(:admin_commonplace, Admin::Commonplace.create!())
  end

  it "renders the edit admin_commonplace form" do
    render

    assert_select "form[action=?][method=?]", admin_commonplace_path(@admin_commonplace), "post" do
    end
  end
end
