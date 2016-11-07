require 'rails_helper'

RSpec.describe "admin/news/index", type: :view do
  before(:each) do
    assign(:admin_news, [
      Admin::News.create!(),
      Admin::News.create!()
    ])
  end

  it "renders a list of admin/news" do
    render
  end
end
