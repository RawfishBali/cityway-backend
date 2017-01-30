class AddSecondAndThirdPhone < ActiveRecord::Migration
  def change
    add_column :utility_places, :phone_1, :string
    add_column :utility_places, :phone_2, :string
  end
end
