class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.float :lat, null: false
      t.float :long, null: false
      t.timestamps null: false
    end
  end
end
