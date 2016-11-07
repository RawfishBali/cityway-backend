require 'rails_helper'

RSpec.describe "admin/stories/show", type: :view do
  before(:each) do
    @admin_story = assign(:admin_story, Admin::Story.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
