class AddSecondAndThirdPhonesToPublicOffices < ActiveRecord::Migration
  def change
    add_column :public_offices, :phone_1, :string
    add_column :public_offices, :phone_2, :string
  end
end
