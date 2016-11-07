class CreateMerchantCategories < ActiveRecord::Migration
  def change
    create_table :categories_merchants do |t|
      t.integer :merchant_id, null: false
      t.integer :category_id, null: false
    end
  end
end
