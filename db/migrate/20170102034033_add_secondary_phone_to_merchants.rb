class AddSecondaryPhoneToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :secondary_phone, :string
  end
end
