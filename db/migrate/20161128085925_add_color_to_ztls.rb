class AddColorToZtls < ActiveRecord::Migration
  def change
    add_column :ztls, :color, :string, default: '#7FB1B6'
  end
end
