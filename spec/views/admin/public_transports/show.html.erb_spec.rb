require 'rails_helper'

RSpec.describe "admin/public_transports/show", type: :view do
  before(:each) do
    @admin_public_transport = assign(:admin_public_transport, Admin::PublicTransport.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
