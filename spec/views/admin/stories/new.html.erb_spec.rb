require 'rails_helper'

RSpec.describe "admin/stories/new", type: :view do
  before(:each) do
    assign(:admin_story, Admin::Story.new())
  end

  it "renders new admin_story form" do
    render

    assert_select "form[action=?][method=?]", admin_stories_path, "post" do
    end
  end
end
