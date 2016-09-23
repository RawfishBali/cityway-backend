# == Schema Information
#
# Table name: markets
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  address     :string           not null
#  latitude    :float
#  longitude   :float
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  around_id   :integer
#

class Market < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :around

  has_many :photos, as: :imageable, dependent: :destroy
  has_many :business_hours, as: :marketable, dependent: :destroy

  belongs_to :around

  geocoded_by :address
  after_validation :geocode
  after_create :create_default_business_hours

  VALID_DAYS = (0..6).to_a

  def primary_photo
    primary_photo = photos.where(is_primary: true).limit(1)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end

  def create_default_business_hours
    7.times do |i|
      self.business_hours << BusinessHour.create(day: i,morning_open_time: '00:00', morning_close_time: '00:00')
    end
  end

  def self.markets_open_on day
    Market.joins(:business_hours).where('business_hours.is_open_today = true AND business_hours.day = ?', Date::DAYNAMES.index(day.titleize))
  end

end
