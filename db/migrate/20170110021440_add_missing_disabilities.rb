class AddMissingDisabilities < ActiveRecord::Migration
  def change
    add_column :places, :support_disabilities, :boolean, default: true
    add_column :culinaries, :support_disabilities, :boolean, default: true
    add_column :markets, :support_disabilities, :boolean, default: true
    add_column :public_offices, :support_disabilities, :boolean, default: true
    add_column :utility_places, :support_disabilities, :boolean, default: true
    add_column :vehicles, :support_disabilities, :boolean, default: true
    add_column :public_transports, :support_disabilities, :boolean, default: true
    add_column :schools, :support_disabilities, :boolean, default: true
  end
end
