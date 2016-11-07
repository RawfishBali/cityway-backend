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

require 'rails_helper'

RSpec.describe WastePickupSchedule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
