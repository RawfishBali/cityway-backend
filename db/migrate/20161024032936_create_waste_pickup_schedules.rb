class CreateWastePickupSchedules < ActiveRecord::Migration
  def change
    create_table :waste_pickup_schedules do |t|
      t.integer :day, null: false
      t.references :waste_management
      t.integer :waste_types, array: true
      t.timestamps null: false
    end
  end
end
