require 'rails_helper'

RSpec.describe "admin/culinaries/edit", type: :view do
  before(:each) do
    @admin_culinary = assign(:admin_culinary, Admin::Culinary.create!())
  end

  it "renders the edit admin_culinary form" do
    render

    assert_select "form[action=?][method=?]", admin_culinary_path(@admin_culinary), "post" do
    end
  end
end
