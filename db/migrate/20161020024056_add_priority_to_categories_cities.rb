class AddPriorityToCategoriesCities < ActiveRecord::Migration
  def change
    add_column :categories_cities, :priority, :integer, default: 0
  end
end
