class AddArounReferencesToMarkets < ActiveRecord::Migration
  def change
    add_column :markets, :around_id, :integer
  end
end
