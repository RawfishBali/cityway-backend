class CreateZtls < ActiveRecord::Migration
  def change
    create_table :ztls do |t|
      t.string :name
      t.text :description
      t.references :utility
      t.timestamps null: false
    end
  end
end
