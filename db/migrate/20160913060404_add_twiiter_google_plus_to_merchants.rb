class AddTwiiterGooglePlusToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :twitter, :string
    add_column :merchants, :google_plus, :string
  end
end
