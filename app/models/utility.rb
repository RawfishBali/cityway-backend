# == Schema Information
#
# Table name: utilities
#
#  id         :integer          not null, primary key
#  photo      :string
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Utility < ActiveRecord::Base
  has_many :devices
  has_many :taxis
  has_many :utility_places, as: :visitable, dependent: :destroy
  has_many :public_transports, dependent: :destroy

  belongs_to :city
  mount_uploader :photo, PhotoUploader

  def devices_by_type device_type
    return [] if (Device.device_types[device_type]).blank?
    devices.where("device_type = ?",Device.device_types[device_type])
  end

  def places_by_type place_type
    return [] if (UtilityPlace.place_types[place_type]).blank?
    utility_places.where("place_type = ?", UtilityPlace.place_types[place_type])
  end

  def transportation_by_type transport_type
    return [] if (PublicTransport.transport_types[transport_type]).blank?
    public_transports.where("transport_type = ?", PublicTransport.transport_types[transport_type])
  end
end
