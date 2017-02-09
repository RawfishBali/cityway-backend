require 'rails_helper'

RSpec.describe "admin/courses/new", type: :view do
  before(:each) do
    assign(:admin_course, Admin::Course.new())
  end

  it "renders new admin_course form" do
    render

    assert_select "form[action=?][method=?]", admin_courses_path, "post" do
    end
  end
end
