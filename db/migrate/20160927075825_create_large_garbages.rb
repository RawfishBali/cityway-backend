class CreateLargeGarbages < ActiveRecord::Migration
  def change
    create_table :large_garbages do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.string :phone
      t.string :website
      t.string :email
      t.text :description
      t.references :utility
      t.timestamps null: false
    end
  end
end
