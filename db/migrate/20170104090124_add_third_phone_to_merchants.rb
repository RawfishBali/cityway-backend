class AddThirdPhoneToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :phone_extra, :string
  end
end
