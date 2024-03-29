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

  has_many :vehicles, dependent: :destroy
  has_many :utility_places, as: :visitable, dependent: :destroy
  has_many :utility_numbers, dependent: :destroy
  has_many :public_transports, dependent: :destroy
  has_many :garbage_glossaries, dependent: :destroy
  has_many :ztls, dependent: :destroy
  has_many :waste_managements, dependent: :destroy
  has_many :schools, dependent: :destroy
  has_many :sports, dependent: :destroy
  has_many :parking_lots, dependent: :destroy
  has_many :courses, dependent: :destroy

  belongs_to :city
  mount_base64_uploader :photo, PhotoUploader

  def devices_by_type device_type
    return [] if (Device.device_types[device_type]).blank?
    devices.where("device_type = ?",Device.device_types[device_type])
  end

  def places_by_type place_type, is_public=nil, commercial=nil, page
    return [] if (UtilityPlace.place_types[place_type]).blank?
    return utility_places.where("place_type = ?", UtilityPlace.place_types[place_type]).page(page) if is_public.nil? && commercial.nil?
    return utility_places.where("place_type = ? and commercial = ?", UtilityPlace.place_types[place_type], commercial).page(page) if is_public.nil? && !commercial.nil?
    return utility_places.where("place_type = ? and is_public = ?", UtilityPlace.place_types[place_type], is_public).page(page) if !is_public.nil? && commercial.nil?
    return utility_places.where("place_type = ? and is_public = ? and commercial = ?", UtilityPlace.place_types[place_type], is_public, commercial).page(page) if !is_public.nil? && !commercial.nil?

  end

  def transportation_by_type transport_type
    return [] if (PublicTransport.transport_types[transport_type]).blank?
    public_transports.where("transport_type = ?", PublicTransport.transport_types[transport_type])
  end

  def vehicles_by_type vehicle_type
    return [] if (Vehicle.vehicle_types[vehicle_type]).blank?
    vehicles.where("vehicle_type = ?", Vehicle.vehicle_types[vehicle_type])
  end

  def waste_management_by_type is_domestic
    if is_domestic.blank?
      is_domestic_value = false
    else
      if is_domestic == true
        is_domestic_value = true
      else
        is_domestic_value = false
      end
    end

    waste_managements.where(is_domestic: is_domestic_value).first
  end

end
