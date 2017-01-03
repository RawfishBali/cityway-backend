class AddIsBasicToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :is_basic, :boolean, default: false
  end
end
