require 'rails_helper'

RSpec.describe "admin/certificates/edit", type: :view do
  before(:each) do
    @admin_certificate = assign(:admin_certificate, Admin::Certificate.create!())
  end

  it "renders the edit admin_certificate form" do
    render

    assert_select "form[action=?][method=?]", admin_certificate_path(@admin_certificate), "post" do
    end
  end
end
