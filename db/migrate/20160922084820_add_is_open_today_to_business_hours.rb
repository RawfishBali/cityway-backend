class AddIsOpenTodayToBusinessHours < ActiveRecord::Migration
  def change
    add_column :business_hours, :is_open_today, :boolean, default: false
  end
end
