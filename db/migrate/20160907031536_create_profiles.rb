class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :role
      t.string :emails, array: true
      t.string :phone
      t.string :fax
      t.integer :days_open, array: true
      t.time :appointment_start
      t.time :appointment_end
      t.string :photo
      t.boolean :is_major , default: false
      t.boolean :is_city_council_member , default: false
      t.integer :political_group_id
      t.references :commonplace
      t.timestamps null: false
    end
  end
end
