class AddSecondAndThirdPhonesToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :phone_1, :string
    add_column :profiles, :phone_2, :string
  end
end
