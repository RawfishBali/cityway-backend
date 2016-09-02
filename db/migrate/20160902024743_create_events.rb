class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :photo, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.string :website
      t.string :email
      t.string :facebook
      t.string :instagram
      t.boolean :support_disabilities, default: false
      t.text :description
      t.datetime :event_start, null: false
      t.references :around, null: false
      t.timestamps null: false
    end
  end
end
