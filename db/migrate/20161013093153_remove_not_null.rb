class RemoveNotNull < ActiveRecord::Migration
  def change
    change_column :advertisements_cities, :city_id, :integer, null: true
    change_column :advertisements_cities, :advertisement_id, :integer, null: true
  end
end
