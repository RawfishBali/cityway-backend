require 'rails_helper'

RSpec.describe "admin/culinaries/new", type: :view do
  before(:each) do
    assign(:admin_culinary, Admin::Culinary.new())
  end

  it "renders new admin_culinary form" do
    render

    assert_select "form[action=?][method=?]", admin_culinaries_path, "post" do
    end
  end
end
