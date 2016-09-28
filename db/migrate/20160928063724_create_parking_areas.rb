class CreateParkingAreas < ActiveRecord::Migration
  def change
    create_table :parking_areas do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :total_parking_lot
      t.integer :available_parking_lot
      t.references :utility
      t.timestamps null: false
    end
  end
end
