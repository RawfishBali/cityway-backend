require 'rails_helper'

RSpec.describe "admin/ztls/show", type: :view do
  before(:each) do
    @admin_ztl = assign(:admin_ztl, Admin::Ztl.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
