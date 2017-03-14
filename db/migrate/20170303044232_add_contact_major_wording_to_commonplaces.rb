class AddContactMajorWordingToCommonplaces < ActiveRecord::Migration
  def change
    add_column :commonplaces, :contact_major_wording, :string
  end
end
