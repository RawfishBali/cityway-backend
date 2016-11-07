require 'rails_helper'

RSpec.describe "admin/public_transports/index", type: :view do
  before(:each) do
    assign(:admin_public_transports, [
      Admin::PublicTransport.create!(),
      Admin::PublicTransport.create!()
    ])
  end

  it "renders a list of admin/public_transports" do
    render
  end
end
