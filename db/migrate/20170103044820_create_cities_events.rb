class CreateCitiesEvents < ActiveRecord::Migration
  def change
    create_table :cities_events do |t|
      t.integer :city_id
      t.integer :event_id

      t.timestamps null: false
    end

    add_index :cities_events, :city_id
    add_index :cities_events, :event_id
  end
end
