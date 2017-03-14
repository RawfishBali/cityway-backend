class AddSectionsToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :sections, :string, array: true
  end
end
