class AddCityIdAndApprovalToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :city_id, :integer
    add_column :promos, :approval, :boolean, default: false
  end
end
