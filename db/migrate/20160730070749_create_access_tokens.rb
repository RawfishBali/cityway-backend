class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :token
      t.datetime :expired_at
      t.integer :client_application_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
