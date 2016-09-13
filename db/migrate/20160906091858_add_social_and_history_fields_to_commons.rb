class AddSocialAndHistoryFieldsToCommons < ActiveRecord::Migration
  def change
    add_column :commonplaces, :history, :text
    add_column :commonplaces, :facebook, :string
    add_column :commonplaces, :instagram, :string
    add_column :commonplaces, :twitter, :string
    add_column :commonplaces, :google_plus, :string
  end
end
