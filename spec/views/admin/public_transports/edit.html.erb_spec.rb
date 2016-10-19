require 'rails_helper'

RSpec.describe "admin/public_transports/edit", type: :view do
  before(:each) do
    @admin_public_transport = assign(:admin_public_transport, Admin::PublicTransport.create!())
  end

  it "renders the edit admin_public_transport form" do
    render

    assert_select "form[action=?][method=?]", admin_public_transport_path(@admin_public_transport), "post" do
    end
  end
end
