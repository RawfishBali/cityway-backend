require 'rails_helper'

RSpec.describe "admin/culinaries/index", type: :view do
  before(:each) do
    assign(:admin_culinaries, [
      Admin::Culinary.create!(),
      Admin::Culinary.create!()
    ])
  end

  it "renders a list of admin/culinaries" do
    render
  end
end
