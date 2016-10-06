require 'rails_helper'

RSpec.describe "admin/parks/index", type: :view do
  before(:each) do
    assign(:admin_parks, [
      Admin::Park.create!(),
      Admin::Park.create!()
    ])
  end

  it "renders a list of admin/parks" do
    render
  end
end
