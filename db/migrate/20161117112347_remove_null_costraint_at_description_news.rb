class RemoveNullCostraintAtDescriptionNews < ActiveRecord::Migration
  def change
    remove_column :news, :description, :text
  end
end
