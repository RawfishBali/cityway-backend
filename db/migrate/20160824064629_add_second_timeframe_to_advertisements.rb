class AddSecondTimeframeToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :second_start_date, :datetime
    add_column :advertisements, :second_end_date, :datetime
  end
end
