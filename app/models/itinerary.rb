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
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

  belongs_to :discover

  validates_presence_of :name
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

  def time_to_complete
    duration = 0
    steps.order('position ASC').each_with_index do |step,i|
      next_step = steps[i+1]
      unless next_step.blank?
        response = HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{step.latitude},#{step.longitude}&destinations=#{next_step.latitude},#{next_step.longitude}&key=AIzaSyC1wjCJ5r9hwVMu4uxLNbcKOfBEaPpchnA")
        if response["rows"][0]["elements"][0]["status"] == "OK"
          duration += response["rows"][0]["elements"][0]["duration"]["value"]
        end
      end
    end
    d = Duration.new(duration)
    if d.hours && d.hours > 0
      "#{d.hours} hours and #{d.minutes} minutes"
    else
      "#{d.minutes} minutes"
    end
  end

end
