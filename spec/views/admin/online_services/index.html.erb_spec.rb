require 'rails_helper'

RSpec.describe "admin/online_services/index", type: :view do
  before(:each) do
    assign(:admin_online_services, [
      Admin::OnlineService.create!(),
      Admin::OnlineService.create!()
    ])
  end

  it "renders a list of admin/online_services" do
    render
  end
end
