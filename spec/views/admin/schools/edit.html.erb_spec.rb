require 'rails_helper'

RSpec.describe "admin/schools/edit", type: :view do
  before(:each) do
    @admin_school = assign(:admin_school, Admin::School.create!())
  end

  it "renders the edit admin_school form" do
    render

    assert_select "form[action=?][method=?]", admin_school_path(@admin_school), "post" do
    end
  end
end
