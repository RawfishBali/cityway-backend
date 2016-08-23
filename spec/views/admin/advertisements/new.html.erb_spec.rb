require 'rails_helper'

RSpec.describe "admin/advertisements/new", type: :view do
  before(:each) do
    assign(:admin_advertisement, Admin::Advertisement.new())
  end

  it "renders new admin_advertisement form" do
    render

    assert_select "form[action=?][method=?]", admin_advertisements_path, "post" do
    end
  end
end
