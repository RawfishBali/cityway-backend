class AddCategoryIdToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants,  :category_id, :integer
  end
end
