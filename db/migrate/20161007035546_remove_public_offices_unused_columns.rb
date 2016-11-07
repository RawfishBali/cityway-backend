class RemovePublicOfficesUnusedColumns < ActiveRecord::Migration
  def change
    remove_column :public_offices, :days_open, :integer
    remove_column :public_offices, :open_time, :time
    remove_column :public_offices, :close_time, :time
  end
end
