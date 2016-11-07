require 'rails_helper'

RSpec.describe "admin/splashes/new", type: :view do
  before(:each) do
    assign(:admin_splash, Admin::Splash.new())
  end

  it "renders new admin_splash form" do
    render

    assert_select "form[action=?][method=?]", admin_splashes_path, "post" do
    end
  end
end
