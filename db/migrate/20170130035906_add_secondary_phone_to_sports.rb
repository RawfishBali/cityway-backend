class AddSecondaryPhoneToSports < ActiveRecord::Migration
  def change
    add_column :sports, :phone_1, :string
    add_column :sports, :phone_2, :string
  end
end
