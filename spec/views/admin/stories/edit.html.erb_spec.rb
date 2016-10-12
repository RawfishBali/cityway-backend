require 'rails_helper'

RSpec.describe "admin/stories/edit", type: :view do
  before(:each) do
    @admin_story = assign(:admin_story, Admin::Story.create!())
  end

  it "renders the edit admin_story form" do
    render

    assert_select "form[action=?][method=?]", admin_story_path(@admin_story), "post" do
    end
  end
end
