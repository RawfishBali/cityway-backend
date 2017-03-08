class AddUnavailableToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :unavailable, :boolean, default: false
  end
end
