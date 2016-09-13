class CreateSecurities < ActiveRecord::Migration
  def change
    create_table :securities do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.references :commonplace
      t.timestamps null: false
    end
  end
end
