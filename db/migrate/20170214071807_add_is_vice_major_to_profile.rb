class AddIsViceMajorToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :is_vice_major, :boolean, default: false
  end
end
