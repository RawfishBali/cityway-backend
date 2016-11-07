require 'rails_helper'

RSpec.describe "admin/events/index", type: :view do
  before(:each) do
    assign(:admin_events, [
      Admin::Event.create!(),
      Admin::Event.create!()
    ])
  end

  it "renders a list of admin/events" do
    render
  end
end
