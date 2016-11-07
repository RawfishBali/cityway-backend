class ReplaceEmailsWithEmailAtProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :emails, :string, array: true
    add_column :profiles, :email, :string
  end
end
