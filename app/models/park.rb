# == Schema Information
#
# Table name: parks
#
#  id                   :integer          not null, primary key
#  name                 :string
#  address              :string
#  latitude             :float
#  longitude            :float
#  support_disabilities :boolean
#  description          :text
#  around_id            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Park < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :around

  has_many :photos, as: :imageable, dependent: :destroy

  belongs_to :around

  geocoded_by :address
  after_validation :geocode

  def primary_photo
    primary_photo = photos.where(is_primary: true).limit(1)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end
end
