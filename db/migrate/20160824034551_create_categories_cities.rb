class CreateCategoriesCities < ActiveRecord::Migration
  def change
    create_table :categories_cities do |t|
      t.integer :city_id, null: false
      t.integer :category_id, null: false
      t.timestamps null: false
    end
    add_index :categories_cities, :city_id
    add_index :categories_cities, :category_id
  end
end
