# == Schema Information
#
# Table name: markets
#
#  id                   :integer          not null, primary key
#  name                 :string           not null
#  address              :string           not null
#  latitude             :float
#  longitude            :float
#  description          :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  around_id            :integer
#  support_disabilities :boolean          default(FALSE)
#

class Market < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :around

  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true
  has_many :business_hours, as: :marketable, dependent: :destroy
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true

  belongs_to :around

  geocoded_by :address
  after_validation :geocode

  VALID_DAYS = (0..6).to_a

  def primary_photo
    primary_photo = photos.where(is_primary: true).limit(1)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end

  def self.markets_open_on day
    markets = []
    open_markets = Market.joins(:business_hours).where('business_hours.day = ?', Date::DAYNAMES.index(Date.parse(day).strftime("%A")))
    open_markets.each do |open_market|
      markets << open_market if open_market.is_open_now?
    end
    return markets
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
    # if mb.size == 7
    # ((0..6).to_a  - mb.map(&:day)).each do |m|
    #   mb << BusinessHour.new(morning_open_time: '00:00', morning_close_time: '00:00', evening_open_time: nil, evening_close_time: nil, day: m, marketable_type: self.class.name, marketable_id: self.id)
    # end
    # mb.sort_by(&:day)
  end

end
