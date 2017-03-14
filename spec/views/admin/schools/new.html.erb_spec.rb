require 'rails_helper'

RSpec.describe "admin/schools/new", type: :view do
  before(:each) do
    assign(:admin_school, Admin::School.new())
  end

  it "renders new admin_school form" do
    render

    assert_select "form[action=?][method=?]", admin_schools_path, "post" do
    end
  end
end
