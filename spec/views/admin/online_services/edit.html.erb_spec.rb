require 'rails_helper'

RSpec.describe "admin/online_services/edit", type: :view do
  before(:each) do
    @admin_online_service = assign(:admin_online_service, Admin::OnlineService.create!())
  end

  it "renders the edit admin_online_service form" do
    render

    assert_select "form[action=?][method=?]", admin_online_service_path(@admin_online_service), "post" do
    end
  end
end
