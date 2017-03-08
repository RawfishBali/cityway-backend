# == Schema Information
#
# Table name: advertisement_durations
#
#  id               :integer          not null, primary key
#  start_date       :date
#  end_date         :date
#  advertisement_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class AdvertisementDuration < ActiveRecord::Base
  belongs_to :advertisement
  validates :start_date, presence: true
  validates :end_date, presence: true
end
