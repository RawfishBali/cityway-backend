class CreateClientApplications < ActiveRecord::Migration
  def change
    create_table :client_applications do |t|
      t.string :name
      t.string :key
      t.string :secret
      t.integer :client_id
      t.timestamps null: false
    end
  end
end
