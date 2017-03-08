class AddNameAndUrlInAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :name, :string
    add_column :advertisements, :url, :string
  end
end
