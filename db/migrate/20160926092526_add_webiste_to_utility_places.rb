class AddWebisteToUtilityPlaces < ActiveRecord::Migration
  def change
    add_column :utility_places, :website, :string
  end
end
