# == Schema Information
#
# Table name: schools
#
#  id                   :integer          not null, primary key
#  name                 :string
#  denomination         :string
#  description          :text
#  address              :string
#  latitude             :float
#  longitude            :float
#  email                :string
#  phone                :string
#  school_type          :string
#  is_public            :boolean
#  website              :string
#  commercial           :boolean
#  utility_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  support_disabilities :boolean          default(FALSE)
#  facebook             :string
#  instagram            :string
#  twitter              :string
#  google_plus          :string
#  phone_1              :string
#  phone_2              :string
#

class School < ActiveRecord::Base
  # :kindergarten, :primary_school, :first_secondary_school, :second_secondary_school, :universities, :music,,:institute, :professional_institute,

  belongs_to :utility

  has_many :business_hours, as: :marketable, dependent: :destroy
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true
  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

  geocoded_by :address
  after_validation :geocode

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

  def is_open_now?
    business_hours.each do |business_hour|
      return true if business_hour.is_open? Time.zone.now
    end
    return false
  end
end
