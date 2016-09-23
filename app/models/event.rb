# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  title                :string           not null
#  photo                :string           not null
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
  validates_presence_of :photo

  geocoded_by :address
  after_validation :geocode

  mount_uploader :photo, PhotoUploader

  has_many :event_dates, dependent: :destroy

  def self.events_open_on day
    Event.joins(:event_dates).where('event_dates.day_name = ? AND event_dates.event_date >= ?', day.titleize, Time.now)
  end

  def is_open_today
    event_dates.each do |event_date|
      return true if event_date.event_date == Date.today
    end
    return false
  end
end
