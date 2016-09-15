class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.references :itinerary
      t.timestamps null: false
    end
  end
end
