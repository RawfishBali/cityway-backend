class CreateGarbageGlossaries < ActiveRecord::Migration
  def change
    create_table :garbage_glossaries do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :utility
      t.timestamps null: false
    end
  end
end
