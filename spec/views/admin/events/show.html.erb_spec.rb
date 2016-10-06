require 'rails_helper'

RSpec.describe "admin/events/show", type: :view do
  before(:each) do
    @admin_event = assign(:admin_event, Admin::Event.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
