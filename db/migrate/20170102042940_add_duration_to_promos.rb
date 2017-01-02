class AddDurationToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :duration, :integer, default: 1
  end
end
