class AddOpenAllDayToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :open_all_day, :boolean, default:false
  end
end
