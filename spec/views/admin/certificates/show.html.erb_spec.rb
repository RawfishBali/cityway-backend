require 'rails_helper'

RSpec.describe "admin/certificates/show", type: :view do
  before(:each) do
    @admin_certificate = assign(:admin_certificate, Admin::Certificate.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
