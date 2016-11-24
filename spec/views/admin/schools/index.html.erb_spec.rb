require 'rails_helper'

RSpec.describe "admin/schools/index", type: :view do
  before(:each) do
    assign(:admin_schools, [
      Admin::School.create!(),
      Admin::School.create!()
    ])
  end

  it "renders a list of admin/schools" do
    render
  end
end
