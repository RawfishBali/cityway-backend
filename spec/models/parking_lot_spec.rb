# == Schema Information
#
# Table name: parking_lots
#
#  id                    :integer          not null, primary key
#  name                  :string           not null
#  address               :string           not null
#  phone                 :string
#  phone_1               :string
#  phone_2               :string
#  email                 :string
#  website               :string
#  facebook              :string
#  instagram             :string
#  twitter               :string
#  google_plus           :string
#  description           :text
#  latitude              :float
#  longitude             :float
#  support_disabilities  :boolean          default(FALSE)
#  photo                 :string
#  icon                  :string
#  is_basic              :boolean          default(FALSE)
#  open_all_day          :boolean
#  total_parking_lot     :integer          default(0)
#  available_parking_lot :integer          default(0)
#  utility_id            :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe ParkingLot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
