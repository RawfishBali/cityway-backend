class RemoveNullConstraint < ActiveRecord::Migration
  def change
    change_column :business_hours, :morning_open_time, :time, null: true
    change_column :business_hours, :morning_close_time, :time, null: true
    change_column :business_hours, :evening_open_time, :time, null: true
    change_column :business_hours, :evening_close_time, :time, null: true
  end
end
