class CreateAdvertisementsCities < ActiveRecord::Migration
  def change
    create_table :advertisements_cities do |t|
      t.integer :city_id, null: false
      t.integer :advertisement_id, null: false
    end

    add_index :advertisements_cities, :city_id
    add_index :advertisements_cities, :advertisement_id
  end
end
