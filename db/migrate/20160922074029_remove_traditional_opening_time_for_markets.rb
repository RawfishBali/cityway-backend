class RemoveTraditionalOpeningTimeForMarkets < ActiveRecord::Migration
  def change
    remove_column :markets, :open_time, :time
    remove_column :markets, :close_time, :time
    remove_column :markets, :day_opens, :integer
  end
end
