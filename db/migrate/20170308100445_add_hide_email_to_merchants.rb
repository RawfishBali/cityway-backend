class AddHideEmailToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :hide_email, :boolean, default: false
  end
end
