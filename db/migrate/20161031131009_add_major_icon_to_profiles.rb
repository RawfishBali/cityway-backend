class AddMajorIconToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :major_icon, :string
  end
end
