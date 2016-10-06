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
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true

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

  def all_business_hours
    mb = (self.business_hours).to_a
    return mb if mb.size == 7
    ((0..6).to_a  - mb.map(&:day)).each do |m|
      mb << BusinessHour.new(morning_open_time: '00:00', morning_close_time: '00:00', evening_open_time: nil, evening_close_time: nil, day: m, marketable_type: self.class.name, marketable_id: self.id)
    end
    mb
  end
end
