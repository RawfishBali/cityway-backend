# == Schema Information
#
# Table name: business_hours
#
#  id                 :integer          not null, primary key
#  day                :integer          not null
#  morning_open_time  :time
#  morning_close_time :time
#  evening_open_time  :time
#  evening_close_time :time
#  open_all_day       :boolean          default(FALSE)
#  marketable_id      :integer
#  marketable_type    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_open_today      :boolean          default(FALSE)
#

class BusinessHour < ActiveRecord::Base
  belongs_to :marketable, polymorphic: true

  validates_inclusion_of :day, in: 0..6
  validates :day, uniqueness: {scope: [:marketable_id, :marketable_type]}, on: :create
  validates :morning_open_time , presence: true
  validates :evening_close_time , presence: true
  validate :close_time_cannot_be_sooner_than_open_time

  def close_time_cannot_be_sooner_than_open_time
    if (morning_close_time && evening_close_time)
      if morning_close_time > evening_close_time
        errors.add(:morning_close_time, "must be smaller than open_time")
      end
    end

    if (evening_open_time && morning_close_time)
      errors.add(:evening_close_time, "must be greater than open_time") if evening_close_time <  evening_open_time
      errors.add(:evening_close_time, "must be greater than evening_open_time") if evening_open_time >  evening_close_time
      errors.add(:morning_close_time, "must be greater than morning_open_time") if morning_close_time <  morning_open_time
    end

  end

  def is_open? now
    return true if (morning_open_time == morning_close_time) || (evening_open_time == evening_close_time) || (morning_open_time == evening_close_time)
    if evening_open_time && morning_close_time
      puts "there"
      (parsed_time(morning_open_time) <= now && parsed_time(morning_close_time) >= now  && now.wday == day) || (parsed_time(evening_open_time) <= now && parsed_time(evening_close_time) >= now  && now.wday == day)
    else
      puts "here"
      (parsed_time(morning_open_time) <= now && parsed_time(evening_close_time) >= now  && now.wday == day)
    end

  end

  def parsed_time field_time
    Time.parse "#{field_time.hour}:#{field_time.min}"
  end

end
