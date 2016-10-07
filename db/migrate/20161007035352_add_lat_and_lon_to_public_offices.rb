class AddLatAndLonToPublicOffices < ActiveRecord::Migration
  def change
    add_column :public_offices, :latitude, :float
    add_column :public_offices, :longitude, :float
  end
end
