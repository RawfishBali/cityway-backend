class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.integer :day , null: false
      t.time :morning_open_time, null: false
      t.time :morning_close_time, null: false
      t.time :evening_open_time
      t.time :evening_close_time
      t.boolean :open_all_day, default: false
      t.references :marketable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
