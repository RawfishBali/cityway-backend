class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.text :path, null: false
      t.references :public_transport
      t.timestamps null: false
    end
    remove_column :public_transports, :path, :string
  end
end
