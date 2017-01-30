class AddSocialToUtilityPlaces < ActiveRecord::Migration
  def change
    add_column :utility_places, :facebook, :string
    add_column :utility_places, :instagram, :string
    add_column :utility_places, :twitter, :string
    add_column :utility_places, :google_plus, :string
  end
end
