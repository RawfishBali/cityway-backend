require 'rails_helper'

RSpec.describe "admin/splashes/show", type: :view do
  before(:each) do
    @admin_splash = assign(:admin_splash, Admin::Splash.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
