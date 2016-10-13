require 'rails_helper'

RSpec.describe "admin/securities/index", type: :view do
  before(:each) do
    assign(:admin_securities, [
      Admin::Security.create!(),
      Admin::Security.create!()
    ])
  end

  it "renders a list of admin/securities" do
    render
  end
end
