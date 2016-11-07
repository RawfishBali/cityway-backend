require 'rails_helper'

RSpec.describe "admin/advertisements/edit", type: :view do
  before(:each) do
    @admin_advertisement = assign(:admin_advertisement, Admin::Advertisement.create!())
  end

  it "renders the edit admin_advertisement form" do
    render

    assert_select "form[action=?][method=?]", admin_advertisement_path(@admin_advertisement), "post" do
    end
  end
end
