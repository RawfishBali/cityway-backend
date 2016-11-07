class CreateArounds < ActiveRecord::Migration
  def change
    create_table :arounds do |t|
      t.string :description
      t.string :photo
      t.references  :city
      t.timestamps null: false
    end
  end
end
