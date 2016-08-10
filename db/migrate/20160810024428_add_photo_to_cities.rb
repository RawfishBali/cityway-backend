class AddPhotoToCities < ActiveRecord::Migration
  def change
    add_column :cities,  :photo, :string
  end
end
