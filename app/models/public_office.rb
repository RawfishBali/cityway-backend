# == Schema Information
#
# Table name: public_offices
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  photo          :string
#  description    :text
#  email          :string
#  address        :string
#  phone          :string
#  fax            :string
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  website        :string
#  latitude       :float
#  longitude      :float
#

class PublicOffice < ActiveRecord::Base
  validates_presence_of :name
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :save }

  belongs_to :commonplace

  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true
  has_many :business_hours, as: :marketable, dependent: :destroy
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true

  geocoded_by :address
  after_validation :geocode

  mount_uploader :photo, PhotoUploader

  phony_normalize :phone, default_country_code: 'IT'
  validates :phone, phony_plausible: true

  def primary_photo
    primary_photo = photos.where(is_primary: true).limit(1)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end

  def all_business_hours
    mb = (self.business_hours).to_a
    return mb.sort_by(&:day)
  end
end
