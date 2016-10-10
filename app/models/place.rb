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
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true
  belongs_to :discover

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :description
  validates_presence_of :place_type

  geocoded_by :address
  after_validation :geocode

  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

  validate :validate_number_of_photos

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

  def get_duration_from latitude , longitude
    response = HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{latitude},#{longitude}&destinations=#{self.latitude},#{self.longitude}&key=AIzaSyC1wjCJ5r9hwVMu4uxLNbcKOfBEaPpchnA")
  end

  def all_business_hours
    mb = (self.business_hours).to_a
    return mb if mb.size == 7
    ((0..6).to_a  - mb.map(&:day)).each do |m|
      mb << BusinessHour.new(morning_open_time: '00:00', morning_close_time: '00:00', evening_open_time: nil, evening_close_time: nil, day: m, marketable_type: self.class.name, marketable_id: self.id)
    end
    mb
  end


end
