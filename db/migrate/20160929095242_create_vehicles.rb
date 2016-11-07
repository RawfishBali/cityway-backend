class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :address
      t.string :phone_0
      t.string :phone_1
      t.string :website
      t.string :email
      t.float :latitude
      t.float :longitude
      t.integer :available_parking_lot
      t.integer :total_parking_lot
      t.integer :vehicle_type
      t.references :utility
      t.timestamps null: false
    end
  end
end
