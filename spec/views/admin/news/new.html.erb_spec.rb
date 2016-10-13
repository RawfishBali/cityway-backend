require 'rails_helper'

RSpec.describe "admin/news/new", type: :view do
  before(:each) do
    assign(:admin_news, Admin::News.new())
  end

  it "renders new admin_news form" do
    render

    assert_select "form[action=?][method=?]", admin_news_index_path, "post" do
    end
  end
end
