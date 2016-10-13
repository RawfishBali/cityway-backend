require 'rails_helper'

RSpec.describe "admin/online_services/new", type: :view do
  before(:each) do
    assign(:admin_online_service, Admin::OnlineService.new())
  end

  it "renders new admin_online_service form" do
    render

    assert_select "form[action=?][method=?]", admin_online_services_path, "post" do
    end
  end
end
