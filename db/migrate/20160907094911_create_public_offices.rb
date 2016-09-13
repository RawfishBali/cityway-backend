class CreatePublicOffices < ActiveRecord::Migration
  def change
    create_table :public_offices do |t|
      t.string :name, null: false
      t.string :photo
      t.text :description
      t.string :email
      t.string :address
      t.string :phone
      t.string :fax
      t.integer :days_open, array:true
      t.time :open_time
      t.time :close_time
      t.references :commonplace
      t.timestamps null: false
    end
  end
end
