class AddAddressToWasteManagement < ActiveRecord::Migration
  def change
    add_column :waste_managements, :address, :string
    add_column :waste_managements, :latitude, :float
    add_column :waste_managements, :longitude, :float
  end
end
