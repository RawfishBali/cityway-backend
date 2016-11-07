class CreateCulinaries < ActiveRecord::Migration
  def change
    create_table :culinaries do |t|
      t.string :name, null: false
      t.text :description
      t.references :discover
      t.integer :culinary_type
      t.timestamps null: false
    end
  end
end
