require 'rails_helper'

RSpec.describe "admin/courses/index", type: :view do
  before(:each) do
    assign(:admin_courses, [
      Admin::Course.create!(),
      Admin::Course.create!()
    ])
  end

  it "renders a list of admin/courses" do
    render
  end
end
