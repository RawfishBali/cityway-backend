class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
      t.date :event_date
      t.string :day_name
      t.time :open_time
      t.time :close_time
      t.references :event, index: true
      t.timestamps null: false
    end

    remove_column :events, :event_start, :datetime
  end
end
