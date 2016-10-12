require 'rails_helper'

RSpec.describe "admin/splashes/index", type: :view do
  before(:each) do
    assign(:admin_splashes, [
      Admin::Splash.create!(),
      Admin::Splash.create!()
    ])
  end

  it "renders a list of admin/splashes" do
    render
  end
end
