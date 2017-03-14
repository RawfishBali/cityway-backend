class AddSecondAndThirdPhonesToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :phone_1, :string
    add_column :places, :phone_2, :string
  end
end
