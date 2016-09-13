class AddMissingIndexes2 < ActiveRecord::Migration
  def change
    add_index :events, :around_id
    add_index :markets, :around_id
    add_index :news, :commonplace_id
    add_index :parks, :around_id
    add_index :politic_groups, :commonplace_id
    add_index :profiles, :politic_group_id
    add_index :profiles, :commonplace_id
    add_index :promos, :merchant_id
    add_index :promos, :city_id
    add_index :public_offices, :commonplace_id
    add_index :securities, :commonplace_id
  end
end
