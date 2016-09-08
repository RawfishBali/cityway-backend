class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.integer :message_type , null: false
      t.text :message , null: false
      t.references :commonplace
      t.timestamps null: false
    end

    add_index :messages, :commonplace_id
  end
end
