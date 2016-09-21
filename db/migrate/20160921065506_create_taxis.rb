class CreateTaxis < ActiveRecord::Migration
  def change
    create_table :taxis do |t|
      t.string :contact_name
      t.string :phone_number
      t.string :website
      t.references :utility
      t.timestamps null: false
    end
  end
end
