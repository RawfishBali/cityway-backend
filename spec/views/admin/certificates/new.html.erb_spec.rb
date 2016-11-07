require 'rails_helper'

RSpec.describe "admin/certificates/new", type: :view do
  before(:each) do
    assign(:admin_certificate, Admin::Certificate.new())
  end

  it "renders new admin_certificate form" do
    render

    assert_select "form[action=?][method=?]", admin_certificates_path, "post" do
    end
  end
end
