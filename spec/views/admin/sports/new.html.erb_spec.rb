require 'rails_helper'

RSpec.describe "admin/sports/new", type: :view do
  before(:each) do
    assign(:admin_sport, Admin::Sport.new())
  end

  it "renders new admin_sport form" do
    render

    assert_select "form[action=?][method=?]", admin_sports_path, "post" do
    end
  end
end
