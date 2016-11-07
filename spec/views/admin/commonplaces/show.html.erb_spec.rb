require 'rails_helper'

RSpec.describe "admin/commonplaces/show", type: :view do
  before(:each) do
    @admin_commonplace = assign(:admin_commonplace, Admin::Commonplace.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
