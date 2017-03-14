class CreateCitiesMerchants < ActiveRecord::Migration
  def change
    create_table :cities_merchants do |t|
      t.integer :city_id, null: false
      t.integer :merchant_id, null: false
      t.timestamps null: false
    end

    add_index :cities_merchants, :city_id
    add_index :cities_merchants, :merchant_id
  end
end
