class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :device_type
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :external_url
      t.references :utility
      t.timestamps null: false
    end
  end
end
