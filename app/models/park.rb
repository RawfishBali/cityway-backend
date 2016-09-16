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
  has_many :business_hours, as: :marketable, dependent: :destroy

  belongs_to :around

  geocoded_by :address
  after_validation :geocode
  after_create :create_default_business_hours



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
end
