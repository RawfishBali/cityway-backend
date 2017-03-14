class AddPhoneToCommonplaces < ActiveRecord::Migration
  def change
    add_column :commonplaces, :phone, :string
    add_column :commonplaces, :override_major, :boolean, default: false
  end
end
