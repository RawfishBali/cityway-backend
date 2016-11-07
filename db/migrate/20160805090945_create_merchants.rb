class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone
      t.string :email
      t.string :website
      t.string :facebook
      t.string :instagram
      t.text :description
      t.float :latitude
      t.float :longitude
      t.boolean :support_disabilities , default: false
      t.timestamps null: false
      t.references  :city
    end
  end
end
