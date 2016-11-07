require 'rails_helper'

RSpec.describe "admin/splashes/edit", type: :view do
  before(:each) do
    @admin_splash = assign(:admin_splash, Admin::Splash.create!())
  end

  it "renders the edit admin_splash form" do
    render

    assert_select "form[action=?][method=?]", admin_splash_path(@admin_splash), "post" do
    end
  end
end
