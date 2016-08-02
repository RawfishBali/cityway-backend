class AddRefreshTokenToAccessToken < ActiveRecord::Migration
  def change
    add_column :access_tokens,  :refresh_token, :string
  end
end
