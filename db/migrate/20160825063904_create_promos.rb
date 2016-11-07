class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.text :title
      t.string :photo
      t.text :description
      t.text :terms_and_conditions
      t.float :discount
      t.float :original_price
      t.float :discount_price
      t.references  :merchant
      t.timestamps null: false
    end
  end
end
