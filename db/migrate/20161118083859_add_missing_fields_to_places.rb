class AddMissingFieldsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :phone, :string
    add_column :places, :external_link, :string
  end
end
