# == Schema Information
#
# Table name: cities_events
#
#  id         :integer          not null, primary key
#  city_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CitiesEvent < ActiveRecord::Base
  belongs_to :city
  belongs_to :event
end
