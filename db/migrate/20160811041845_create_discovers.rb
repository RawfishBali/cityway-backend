class CreateDiscovers < ActiveRecord::Migration
  def change
    create_table :discovers do |t|
      t.string :description
      t.string :photo
      t.references  :city
      t.timestamps null: false
    end
  end
end
