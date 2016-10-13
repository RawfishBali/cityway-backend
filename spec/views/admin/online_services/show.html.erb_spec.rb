require 'rails_helper'

RSpec.describe "admin/online_services/show", type: :view do
  before(:each) do
    @admin_online_service = assign(:admin_online_service, Admin::OnlineService.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
