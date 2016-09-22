# == Schema Information
#
# Table name: itineraries
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  description   :text
#  discover_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  visiting_time :string
#

class Itinerary < ActiveRecord::Base
  has_many :photos, as: :imageable, dependent: :destroy
  has_many :steps, dependent: :destroy

  belongs_to :discover

  validates_presence_of :name
  validates_presence_of :discover
  validates_length_of :description, maximum: 2000

  validate :validate_number_of_photos

  def validate_number_of_photos
    errors.add(:photos, "Maximum photos is 3") if photos.size > 3
  end

  def primary_photo
    primary_photo = photos.where(is_primary: true)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end

  def get_duration_from latitude , longitude
    response = HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{latitude},#{longitude}&destinations=#{self.steps.first.latitude},#{self.steps.first.longitude}&key=AIzaSyC1wjCJ5r9hwVMu4uxLNbcKOfBEaPpchnA")
  end

end
