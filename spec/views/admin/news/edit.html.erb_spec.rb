require 'rails_helper'

RSpec.describe "admin/news/edit", type: :view do
  before(:each) do
    @admin_news = assign(:admin_news, Admin::News.create!())
  end

  it "renders the edit admin_news form" do
    render

    assert_select "form[action=?][method=?]", admin_news_path(@admin_news), "post" do
    end
  end
end
