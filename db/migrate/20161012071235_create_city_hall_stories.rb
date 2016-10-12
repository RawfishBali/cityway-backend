class CreateCityHallStories < ActiveRecord::Migration
  def change
    create_table :city_hall_stories do |t|
      t.text :top_text, null: false
      t.text :bottom_text, null: false
      t.references :commonplace
      t.timestamps null: false
    end
  end
end
