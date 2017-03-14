class CreateParkingLots < ActiveRecord::Migration
  def change
    create_table :parking_lots do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone
      t.string :phone_1
      t.string :phone_2
      t.string :email
      t.string :website
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :google_plus
      t.text :description
      t.float :latitude
      t.float :longitude
      t.boolean :support_disabilities , default: false
      t.string :photo
      t.string :icon
      t.boolean :is_basic, default: false
      t.boolean :open_all_day
      t.integer :total_parking_lot, default: 0
      t.integer :available_parking_lot, default: 0
      t.integer :utility_id
      t.timestamps null: false
    end
  end
end
