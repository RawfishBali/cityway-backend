class AddMobileNumberToUtilityNumbers < ActiveRecord::Migration
  def change
    add_column :utility_numbers, :mobile_number, :string
  end
end
