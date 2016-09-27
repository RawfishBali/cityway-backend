class AddCityHallNameToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :city_hall_name, :string
  end
end
