class RemoveCitiesMerchantNotNull < ActiveRecord::Migration
  def change
    change_column :cities_merchants, :city_id, :integer, null: true
    change_column :cities_merchants, :merchant_id, :integer, null: true
  end
end
