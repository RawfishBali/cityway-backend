class AddMerchantIdToAdmins < ActiveRecord::Migration
  def change
    add_column :merchants, :admin_id, :integer
  end
end
