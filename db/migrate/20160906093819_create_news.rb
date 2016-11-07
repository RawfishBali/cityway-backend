class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title, null: false
      t.string :photo
      t.datetime :published_at, null: false
      t.text :description, null: false
      t.references :commonplace, null: false
      t.timestamps null: false
    end
  end
end
