# == Schema Information
#
# Table name: merchants
#
#  id                   :integer          not null, primary key
#  name                 :string           not null
#  address              :string           not null
#  phone                :string
#  email                :string
#  website              :string
#  facebook             :string
#  instagram            :string
#  description          :text
#  latitude             :float
#  longitude            :float
#  support_disabilities :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  city_id              :integer
#  category_id          :integer
#  photo                :string
#  icon                 :string
#  twitter              :string
#  google_plus          :string
#  active               :boolean          default(TRUE)
#  activated_at         :datetime
#  deactivated_at       :datetime
#

class Merchant < ActiveRecord::Base
  has_and_belongs_to_many :subcategories, class_name: 'Category'
  has_many :promos, dependent: :destroy
  has_many :business_hours, as: :marketable, dependent: :destroy
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true
  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true
  belongs_to :category
  belongs_to :city

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :icon
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :save }

  mount_base64_uploader :icon, PhotoUploader

  geocoded_by :address
  after_validation :geocode

  phony_normalize :phone, default_country_code: 'IT'
  validates :phone, phony_plausible: true

  before_save :set_activation, if: :active_changed?
  before_create :set_activation

  scope :active_merchants, -> { where("deactivated_at >= ?", Time.zone.now) }

  def primary_photo
    primary_photo = photos.where(is_primary: true)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end

  def is_open_now?
    business_hours.each do |business_hour|
      return true if business_hour.is_open? Time.zone.now
    end
    return false
  end

  def all_business_hours
    mb = (self.business_hours).to_a
    return mb.sort_by(&:day)
  end

  def active_promos
    promos.where("activated_at <= ? and deactivated_at >= ?", Time.zone.now, Time.zone.now)
  end

  def is_active
    return false unless active
    return false if self.activated_at.blank? && self.deactivated_at.blank?
    return true if self.activated_at <= Time.zone.now && self.deactivated_at >= Time.zone.now
    return false
  end

  def set_activation
    if active
      self.activated_at = Time.zone.now
      self.deactivated_at = Time.zone.now + 1.year
    else
      self.activated_at = nil
      self.activated_at = nil
    end
  end
end
