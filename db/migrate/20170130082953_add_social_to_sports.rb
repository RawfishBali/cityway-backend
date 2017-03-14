class AddSocialToSports < ActiveRecord::Migration
  def change
    add_column :sports, :facebook, :string
    add_column :sports, :instagram, :string
    add_column :sports, :twitter, :string
    add_column :sports, :google_plus, :string
  end
end
