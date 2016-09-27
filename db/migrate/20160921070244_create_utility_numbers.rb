class CreateUtilityNumbers < ActiveRecord::Migration
  def change
    create_table :utility_numbers do |t|
      t.string :name
      t.string :local_number
      t.string :national_number
      t.string :address
      t.references :utility
      t.timestamps null: false
    end
  end
end
