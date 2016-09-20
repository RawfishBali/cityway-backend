class AddVisitingTimeToItineraries < ActiveRecord::Migration
  def change
    add_column :itineraries, :visiting_time, :string
  end
end
