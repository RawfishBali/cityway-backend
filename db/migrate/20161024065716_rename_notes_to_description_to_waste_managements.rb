class RenameNotesToDescriptionToWasteManagements < ActiveRecord::Migration
  def change
    rename_column :waste_managements, :note, :description
  end
end
