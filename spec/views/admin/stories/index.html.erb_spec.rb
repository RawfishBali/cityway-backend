require 'rails_helper'

RSpec.describe "admin/stories/index", type: :view do
  before(:each) do
    assign(:admin_stories, [
      Admin::Story.create!(),
      Admin::Story.create!()
    ])
  end

  it "renders a list of admin/stories" do
    render
  end
end
