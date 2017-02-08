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

class ParkingLot < ActiveRecord::Base
  belongs_to :utility

  has_many :business_hours, as: :marketable, dependent: :destroy
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true

  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

  def primary_photo
    primary_photo = photos.where(is_primary: true)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end

  def is_open_now?
    return true if open_all_day
    business_hours.each do |business_hour|
      return true if business_hour.is_open? Time.zone.now
    end
    return false
  end

  def all_business_hours
    mb = (self.business_hours).to_a
    return mb.sort_by(&:day)
  end
end
