# == Schema Information
#
# Table name: utility_places
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
#  place_type           :integer
#  visitable_id         :integer
#  visitable_type       :string
#  is_public            :boolean          default(TRUE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  website              :string
#  commercial           :boolean
#  support_disabilities :boolean          default(FALSE)
#  facebook             :string
#  instagram            :string
#  twitter              :string
#  google_plus          :string
#  phone_1              :string
#  phone_2              :string
#  open_all_day         :boolean          default(FALSE)
#

class UtilityPlace < ActiveRecord::Base
  enum place_type: [:post_office, :pharmacies, :water_house, :waste_recycling, :structures, :social_services, :voluntary_association, :elder_home, :young_people_place,  :large_garbage, :recycling_place ]

  HAS_BUSINESSHOUR = ['voluntary_association', 'social_services', 'structures', 'tennis_court','public_swimming_pool', 'post_office', 'pharmacies', 'large_garbage']

  has_many :business_hours, as: :marketable, dependent: :destroy
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true
  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

  geocoded_by :address
  after_validation :geocode

  phony_normalize :phone, default_country_code: 'IT'
  validates :phone, phony_plausible: true

  after_save :update_business_hours, if: :open_all_day_changed?

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
    return true if open_all_day
    business_hours.each do |business_hour|
      return true if business_hour.is_open? Time.zone.now
    end
    return false
  end

  def update_business_hours
    if open_all_day
      business_hours.destroy_all
    end
  end

end
