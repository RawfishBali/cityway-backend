# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  address     :string
#  latitude    :float
#  longitude   :float
#  email       :string
#  website     :string
#  facebook    :string
#  instagram   :string
#  twitter     :string
#  google_plus :string
#  discover_id :integer
#  place_type  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Place < ActiveRecord::Base
  enum place_type: [:monument, :library, :theater, :museum, :cinema]

  has_many :business_hours, as: :marketable, dependent: :destroy
  belongs_to :discover

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :description
  validates_presence_of :place_type

  geocoded_by :address
  after_validation :geocode

  has_many :photos, as: :imageable, dependent: :destroy

  validate :validate_number_of_photos

  after_create :create_default_business_hours

  def validate_number_of_photos
    errors.add(:photos, "Maximum photos is 3") if photos.size > 2
  end

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
      self.business_hours << BusinessHour.create(day: i,morning_open_time: '00:00', morning_close_time: '00:00', evening_open_time: '00:00', evening_close_time: '00:00')
    end
  end

end
