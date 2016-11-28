class AddActivateToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :active, :boolean, default: true
    add_column :merchants, :activated_at, :datetime
    add_column :merchants, :deactivated_at, :datetime
  end
end
