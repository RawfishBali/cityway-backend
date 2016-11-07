class CreateWasteTypes < ActiveRecord::Migration
  def change
    create_table :waste_types do |t|
      t.string :name , null: false
      t.string :icon , null: false
      t.timestamps null: false
    end
  end
end
