class AddCommercialToUtilityPlaces < ActiveRecord::Migration
  def change
    add_column :utility_places, :commercial, :boolean
  end
end
