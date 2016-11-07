require 'rails_helper'

RSpec.describe "admin/advertisements/index", type: :view do
  before(:each) do
    assign(:admin_advertisements, [
      Admin::Advertisement.create!(),
      Admin::Advertisement.create!()
    ])
  end

  it "renders a list of admin/advertisements" do
    render
  end
end
