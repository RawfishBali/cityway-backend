class RemoveUnecessaryDescriptionFields < ActiveRecord::Migration
  def change
    remove_column :utilities,  :description, :string
    remove_column :commonplaces,  :description, :string
    remove_column :arounds,  :description, :string
    remove_column :discovers,  :description, :string
  end
end
