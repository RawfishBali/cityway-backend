class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :top_text
      t.text :bottom_text
      t.references :discover
      t.timestamps null: false
    end
  end
end
