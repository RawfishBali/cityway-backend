class RemoveDistanceFromCities < ActiveRecord::Migration
  def change
    remove_column :cities,  :distance, :float
  end
end
