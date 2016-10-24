# == Schema Information
#
# Table name: waste_pickup_schedules
#
#  id                  :integer          not null, primary key
#  day                 :integer          not null
#  waste_management_id :integer
#  waste_types         :integer          is an Array
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class WastePickupSchedule < ActiveRecord::Base
  validates_presence_of :day
  belongs_to :waste_management

end
