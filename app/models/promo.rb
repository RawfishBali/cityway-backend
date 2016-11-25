# == Schema Information
#
# Table name: promos
#
#  id                   :integer          not null, primary key
#  title                :text
#  photo                :string
#  description          :text
#  terms_and_conditions :text
#  discount             :float
#  original_price       :float
#  discount_price       :float
#  merchant_id          :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  city_id              :integer
#  approval             :boolean          default(TRUE)
#  activated_at         :datetime
#  deactivated_at       :datetime
#

class Promo < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :city

  validates_presence_of :title
  validates_presence_of :photo
  validates_presence_of :description
  validates_presence_of :terms_and_conditions
  validates_presence_of :discount
  validates_presence_of :original_price
  validates_presence_of :merchant
  validates_presence_of :city

  validates :discount, numericality: {greater_than_or_equal_to: 0}
  validates :original_price, numericality: {greater_than_or_equal_to: 0}

  mount_base64_uploader :photo, PhotoUploader

  before_save :calculate_discounted_price
  before_save :set_activation, if: :approval_changed?
  before_create :set_activation

  def category
    merchant.category
  end

  def subcategories
    merchant.subcategories
  end

  def is_active
    return false unless approval
    return false if self.activated_at.blank? && self.deactivated_at.blank?
    return true if self.activated_at <= Time.zone.now && self.deactivated_at >= Time.zone.now
    return false
  end

  def is_active_for_tommorow
    return true if self.activated_at == Time.zone.parse("08:00 am") + 1.day
    return false
  end

  private

  def calculate_discounted_price
    self.discount_price =  self.original_price - (self.original_price * (self.discount/100))
  end

  def set_activation
    if approval
      if Time.zone.now > Time.zone.parse("08:00 am")
        self.activated_at = Time.zone.parse("08:00 am") + 1.day
        self.deactivated_at = Time.zone.parse("08:00 pm") + 14.day
      else
        self.activated_at = Time.zone.parse("08:00 am")
        self.deactivated_at = Time.zone.parse("08:00 pm") + 14.day
      end
    else
      self.activated_at = nil
      self.activated_at = nil
    end
  end
end
