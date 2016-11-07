require 'rails_helper'

RSpec.describe "admin/events/edit", type: :view do
  before(:each) do
    @admin_event = assign(:admin_event, Admin::Event.create!())
  end

  it "renders the edit admin_event form" do
    render

    assert_select "form[action=?][method=?]", admin_event_path(@admin_event), "post" do
    end
  end
end
