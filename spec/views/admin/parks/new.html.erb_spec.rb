require 'rails_helper'

RSpec.describe "admin/parks/new", type: :view do
  before(:each) do
    assign(:admin_park, Admin::Park.new())
  end

  it "renders new admin_park form" do
    render

    assert_select "form[action=?][method=?]", admin_parks_path, "post" do
    end
  end
end
