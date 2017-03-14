require 'rails_helper'

RSpec.describe "admin/sports/show", type: :view do
  before(:each) do
    @admin_sport = assign(:admin_sport, Admin::Sport.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
