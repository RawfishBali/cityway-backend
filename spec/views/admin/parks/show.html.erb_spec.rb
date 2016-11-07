require 'rails_helper'

RSpec.describe "admin/parks/show", type: :view do
  before(:each) do
    @admin_park = assign(:admin_park, Admin::Park.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
