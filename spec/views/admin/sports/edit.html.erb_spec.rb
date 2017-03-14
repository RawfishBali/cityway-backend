require 'rails_helper'

RSpec.describe "admin/sports/edit", type: :view do
  before(:each) do
    @admin_sport = assign(:admin_sport, Admin::Sport.create!())
  end

  it "renders the edit admin_sport form" do
    render

    assert_select "form[action=?][method=?]", admin_sport_path(@admin_sport), "post" do
    end
  end
end
