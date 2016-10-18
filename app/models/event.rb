# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  title                :string           not null
#  address              :string           not null
#  latitude             :float
#  longitude            :float
#  website              :string
#  email                :string
#  facebook             :string
#  instagram            :string
#  support_disabilities :boolean          default(FALSE)
#  description          :text
#  around_id            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Event < ActiveRecord::Base

  belongs_to :around

  validates_presence_of :title
  validates_presence_of :address
  validates_presence_of :description
  validates_presence_of :around

  geocoded_by :address
  after_validation :geocode

  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

  has_many :event_dates, dependent: :destroy
  accepts_nested_attributes_for :event_dates, reject_if: :all_blank, allow_destroy: true

  def self.events_open_on day
    Event.joins(:event_dates).where('event_dates.day_name = ? AND event_dates.event_date >= ?', day.titleize, Time.now)
  end

  def is_open_today
    event_dates.each do |event_date|
      return true if event_date.event_date == Date.today
    end
    return false
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
