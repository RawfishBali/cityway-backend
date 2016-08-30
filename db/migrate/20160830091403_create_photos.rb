class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string  :picture
      t.references :imageable, polymorphic: true, index: true
      t.boolean :is_primary , default: false
      t.timestamps null: false
    end
  end
end
