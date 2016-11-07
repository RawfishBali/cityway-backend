require 'rails_helper'

RSpec.describe "admin/culinaries/show", type: :view do
  before(:each) do
    @admin_culinary = assign(:admin_culinary, Admin::Culinary.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
