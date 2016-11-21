class ExternalLinkToCityHallStories < ActiveRecord::Migration
  def change
    add_column :city_hall_stories , :external_link , :string
  end
end
