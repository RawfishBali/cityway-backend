class CreateAdvertisementDurations < ActiveRecord::Migration
  def change
    create_table :advertisement_durations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :advertisement_id
      t.timestamps null: false
    end

    remove_column :advertisements, :start_date
    remove_column :advertisements, :end_date
    remove_column :advertisements, :second_start_date
    remove_column :advertisements, :second_end_date
  end
end
