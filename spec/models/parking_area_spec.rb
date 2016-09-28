# == Schema Information
#
# Table name: parking_areas
#
#  id                    :integer          not null, primary key
#  name                  :string
#  address               :string
#  latitude              :float
#  longitude             :float
#  total_parking_lot     :integer
#  available_parking_lot :integer
#  utility_id            :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe ParkingArea, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
