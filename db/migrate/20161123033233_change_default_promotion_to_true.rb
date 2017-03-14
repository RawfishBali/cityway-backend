class ChangeDefaultPromotionToTrue < ActiveRecord::Migration
  def change
    change_column :promos, :approval, :boolean, default: true
  end
end
