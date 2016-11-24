require 'rails_helper'

RSpec.describe "admin/schools/show", type: :view do
  before(:each) do
    @admin_school = assign(:admin_school, Admin::School.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
