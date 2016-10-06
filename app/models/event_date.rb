# == Schema Information
#
# Table name: event_dates
#
#  id         :integer          not null, primary key
#  event_date :date
#  day_name   :string
#  open_time  :time
#  close_time :time
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventDate < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :event_date
  validates_presence_of :open_time
  validates_presence_of :close_time

  before_save :create_day_name

  def create_day_name
    self.day_name = self.event_date.strftime("%A")
  end
end
