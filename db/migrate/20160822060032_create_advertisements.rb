class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :photo
      t.boolean :active , default: false
      t.integer :position
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps null: false
    end
  end
end
