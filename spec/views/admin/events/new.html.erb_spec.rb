require 'rails_helper'

RSpec.describe "admin/events/new", type: :view do
  before(:each) do
    assign(:admin_event, Admin::Event.new())
  end

  it "renders new admin_event form" do
    render

    assert_select "form[action=?][method=?]", admin_events_path, "post" do
    end
  end
end
