class RemovePhotoFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :photo, :string
  end
end
