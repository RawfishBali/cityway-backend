class ChangeColumnNamesAndAddDescription < ActiveRecord::Migration
  def change
    add_column :cities,  :description, :text
    rename_column :cities, :lat, :latitude
    rename_column :cities, :long, :longitude
  end
end
