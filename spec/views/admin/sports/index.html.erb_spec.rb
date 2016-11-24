require 'rails_helper'

RSpec.describe "admin/sports/index", type: :view do
  before(:each) do
    assign(:admin_sports, [
      Admin::Sport.create!(),
      Admin::Sport.create!()
    ])
  end

  it "renders a list of admin/sports" do
    render
  end
end
