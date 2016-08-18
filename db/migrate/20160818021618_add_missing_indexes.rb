class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :utilities, :city_id
    add_index :categories_merchants, :category_id
    add_index :merchants, :category_id
    add_index :merchants, :city_id
    add_index :discovers, :city_id
    add_index :commonplaces, :city_id
    add_index :access_tokens, :client_application_id
    add_index :access_tokens, :user_id
    add_index :arounds, :city_id
    add_index :categories, :parent_id
    add_index :categories_merchants, :merchant_id
    add_index :subcategories, :category_id
  end
end
