class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :email
      t.string :website
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :google_plus
      t.references :discover
      t.integer :place_type
      t.timestamps null: false
    end
  end
end
