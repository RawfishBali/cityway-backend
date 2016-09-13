class CreatePoliticGroups < ActiveRecord::Migration
  def change
    create_table :politic_groups do |t|
      t.string :name, null: false
      t.references :commonplace
      t.timestamps null: false
    end

    rename_column :profiles, :political_group_id, :politic_group_id
  end
end
