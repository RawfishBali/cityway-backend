class AddPositionToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :position, :integer
  end
end
