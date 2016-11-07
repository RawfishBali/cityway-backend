require 'rails_helper'

RSpec.describe "admin/certificates/index", type: :view do
  before(:each) do
    assign(:admin_certificates, [
      Admin::Certificate.create!(),
      Admin::Certificate.create!()
    ])
  end

  it "renders a list of admin/certificates" do
    render
  end
end
