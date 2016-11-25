class AddActivatedAtAndDeactivatedAtToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :activated_at, :datetime
    add_column :promos, :deactivated_at, :datetime
  end
end
