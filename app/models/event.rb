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
#  event_start          :datetime         not null
#  around_id            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Event < ActiveRecord::Base

  belongs_to :around

  validates_presence_of :title
  validates_presence_of :address
  validates_presence_of :description
  validates_presence_of :event_start
  validates_presence_of :around
  validates_presence_of :photo

  geocoded_by :address
  after_validation :geocode
  after_create :create_default_business_hours

  mount_uploader :photo, PhotoUploader
  
  has_many :business_hours, as: :marketable, dependent: :destroy

  def create_default_business_hours
    7.times do |i|
      self.business_hours << BusinessHour.create(day: i,morning_open_time: '00:00', morning_close_time: '00:00')
    end
  end
end
