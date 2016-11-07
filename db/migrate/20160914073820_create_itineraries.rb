class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string :name, null: false
      t.text :description
      t.references :discover
      t.timestamps null: false
    end
  end
end
