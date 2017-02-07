class AddOpenAllDayToUtilityPlaces < ActiveRecord::Migration
  def change
    add_column :utility_places, :open_all_day, :boolean, default: false
  end
end
