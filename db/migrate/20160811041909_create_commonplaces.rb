class CreateCommonplaces < ActiveRecord::Migration
  def change
    create_table :commonplaces do |t|
      t.string :description
      t.string :photo
      t.string :icon
      t.references  :city
      t.timestamps null: false
    end
  end
end
