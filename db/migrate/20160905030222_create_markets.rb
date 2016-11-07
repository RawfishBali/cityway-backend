class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.float  :latitude
      t.float  :longitude
      t.time   :open_time, null: false
      t.time   :close_time, null: false
      t.text   :description
      t.integer :day_opens, array: true
      t.timestamps null: false
    end

    add_index :markets, :day_opens
  end
end
