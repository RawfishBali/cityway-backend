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
#  approval             :boolean          default(FALSE)
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

  def category
    merchant.category
  end

  def subcategories
    merchant.subcategories
  end

  private

  def calculate_discounted_price
    self.discount_price =  self.original_price - (self.original_price * (self.discount/100))
  end
end
