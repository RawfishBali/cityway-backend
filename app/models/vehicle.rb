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
#

class Vehicle < ActiveRecord::Base
  enum vehicle_type: [:taxi,:bike,:parking]

  belongs_to :utility

  validates_presence_of :utility
  validates_presence_of :name
  validates_presence_of :address

  geocoded_by :address
  after_validation :geocode
end
