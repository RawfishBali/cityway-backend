require 'rails_helper'

RSpec.describe "admin/news/show", type: :view do
  before(:each) do
    @admin_news = assign(:admin_news, Admin::News.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
