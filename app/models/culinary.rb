# == Schema Information
#
# Table name: culinaries
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  description   :text
#  discover_id   :integer
#  culinary_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Culinary < ActiveRecord::Base
  enum culinary_type: [:traditional, :gastronomy]

  belongs_to :discover

  validates_presence_of :discover
  validates_presence_of :name
  validates_presence_of :culinary_type

  has_many :photos, as: :imageable, dependent: :destroy

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
end
