class AddDistanceToCities < ActiveRecord::Migration
  def change
    add_column :cities,  :distance, :float
    add_index  :cities, [:lat, :long]
  end
end
