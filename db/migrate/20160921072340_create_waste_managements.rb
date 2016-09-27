class CreateWasteManagements < ActiveRecord::Migration
  def change
    create_table :waste_managements do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :website
      t.text :note
      t.boolean :delivered_together , default: false
      t.references :utility
      t.timestamps null: false
    end
  end
end
