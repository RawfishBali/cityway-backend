require 'rails_helper'

RSpec.describe "admin/courses/show", type: :view do
  before(:each) do
    @admin_course = assign(:admin_course, Admin::Course.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
