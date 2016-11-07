class CreateOnlineServices < ActiveRecord::Migration
  def change
    create_table :online_services do |t|
      t.string :name
      t.string :url
      t.references :commonplace
      t.timestamps null: false
    end
  end
end
