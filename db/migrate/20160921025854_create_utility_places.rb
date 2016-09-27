class CreateUtilityPlaces < ActiveRecord::Migration
  def change
    create_table :utility_places do |t|
      t.string :name
      t.string :denomination
      t.text :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :email
      t.string :phone
      t.integer :place_type
      t.references :visitable, polymorphic: true, index: true
      t.boolean :is_public, default: true
      t.timestamps null: false
    end
  end
end
