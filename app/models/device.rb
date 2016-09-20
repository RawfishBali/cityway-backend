# == Schema Information
#
# Table name: devices
#
#  id           :integer          not null, primary key
#  device_type  :integer
#  latitude     :float
#  longitude    :float
#  address      :string
#  external_url :string
#  utility_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Device < ActiveRecord::Base
  enum device_type: [:wifi, :webcam]

  belongs_to :utility

  validates_presence_of :device_type

  geocoded_by :address
  after_validation :geocode
end
