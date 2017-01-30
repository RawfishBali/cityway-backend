class AddSocialToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :facebook, :string
    add_column :schools, :instagram, :string
    add_column :schools, :twitter, :string
    add_column :schools, :google_plus, :string
    add_column :schools, :phone_1, :string
    add_column :schools, :phone_2, :string
  end
end
