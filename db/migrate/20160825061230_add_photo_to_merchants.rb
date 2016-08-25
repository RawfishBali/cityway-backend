class AddPhotoToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :photo, :string
    add_column :merchants, :icon, :string
  end
end
