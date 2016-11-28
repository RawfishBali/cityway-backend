class AddPredifinedColumnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :predifined, :boolean, default: false
  end
end
