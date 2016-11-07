class AddWebsiteToPublicOffices < ActiveRecord::Migration
  def change
    add_column :public_offices, :website, :string
  end
end
