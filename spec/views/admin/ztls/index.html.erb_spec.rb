require 'rails_helper'

RSpec.describe "admin/ztls/index", type: :view do
  before(:each) do
    assign(:admin_ztls, [
      Admin::Ztl.create!(),
      Admin::Ztl.create!()
    ])
  end

  it "renders a list of admin/ztls" do
    render
  end
end
