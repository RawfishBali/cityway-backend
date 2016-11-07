class AddIsDomesticToWasteManagements < ActiveRecord::Migration
  def change
    add_column :waste_managements, :is_domestic, :boolean, default: true
  end
end
