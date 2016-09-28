class CreatePublicTransports < ActiveRecord::Migration
  def change
    create_table :public_transports do |t|
      t.string :name
      t.string :attachment
      t.integer :transport_type
      t.text :path
      t.references :utility
      t.timestamps null: false
    end
  end
end
