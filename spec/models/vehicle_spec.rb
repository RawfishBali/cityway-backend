# == Schema Information
#
# Table name: vehicles
#
#  id                    :integer          not null, primary key
#  name                  :string
#  address               :string
#  phone_0               :string
#  phone_1               :string
#  website               :string
#  email                 :string
#  latitude              :float
#  longitude             :float
#  available_parking_lot :integer
#  total_parking_lot     :integer
#  vehicle_type          :integer
#  utility_id            :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  support_disabilities  :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
