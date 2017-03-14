class AddCommonplaceReplaceable < ActiveRecord::Migration
  def change
    add_column :commonplaces , :replaceable_phone, :string, default: ""
    add_column :commonplaces , :replaceable_email, :string, default: ""
    add_column :commonplaces , :replaceable_icon, :string, default: ""
    remove_column :commonplaces , :contact_major_wording, :string, default: ""
  end
end
