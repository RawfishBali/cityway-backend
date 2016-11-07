class ChangeDefaultPriorityValue < ActiveRecord::Migration
  def change
    change_column :categories_cities, :priority, :integer, default: 999
  end
end
