class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :support_disabilities
      t.text :description
      t.references :around, null: false
      t.timestamps null: false
    end
  end
end
