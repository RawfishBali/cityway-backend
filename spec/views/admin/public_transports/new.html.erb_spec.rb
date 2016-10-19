require 'rails_helper'

RSpec.describe "admin/public_transports/new", type: :view do
  before(:each) do
    assign(:admin_public_transport, Admin::PublicTransport.new())
  end

  it "renders new admin_public_transport form" do
    render

    assert_select "form[action=?][method=?]", admin_public_transports_path, "post" do
    end
  end
end
