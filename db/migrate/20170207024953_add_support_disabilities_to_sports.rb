class AddSupportDisabilitiesToSports < ActiveRecord::Migration
  def change
    add_column :sports, :support_disabilities, :boolean, default: false
  end
end
