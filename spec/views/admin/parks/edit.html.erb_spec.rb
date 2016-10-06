require 'rails_helper'

RSpec.describe "admin/parks/edit", type: :view do
  before(:each) do
    @admin_park = assign(:admin_park, Admin::Park.create!())
  end

  it "renders the edit admin_park form" do
    render

    assert_select "form[action=?][method=?]", admin_park_path(@admin_park), "post" do
    end
  end
end
