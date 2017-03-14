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
#  twitter              :string
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

  has_many :cities , through: :cities_events
  has_many :cities_events, dependent: :destroy

  def self.events_open_on day
    Event.joins(:event_dates).where('event_dates.event_date = ?', Date.parse(day))
  end

  def is_open_today
    event_dates.each do |event_date|
      if event_date.event_date == Date.today
        return true if parsed_time(event_date.open_time) <= Time.zone.now && parsed_time(event_date.close_time) >= Time.zone.now
      else
        next
      end
    end
    return false
  end

  def parsed_time field_time
    Time.zone.parse "#{field_time.hour}:#{field_time.min}"
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
