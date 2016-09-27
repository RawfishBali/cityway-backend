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
  validates_presence_of :open_time
  validates_presence_of :close_time
  validates_presence_of :around
  validate :validate_day_opens

  has_many :photos, as: :imageable, dependent: :destroy

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
  
  private

  def validate_day_opens
    if (day_opens = (self.day_opens - VALID_DAYS))
      day_opens.each do |day_open|
        errors.add(:day_opens, day_open.to_s + " is not a valid days")
      end
    end
  end


end
