# == Schema Information
#
# Table name: steps
#
#  id           :integer          not null, primary key
#  address      :string           not null
#  latitude     :float
#  longitude    :float
#  itinerary_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  name         :string
#  description  :text
#  position     :integer
#

class Step < ActiveRecord::Base
  belongs_to :itinerary

  validates_presence_of :itinerary
  validates_presence_of :address

  geocoded_by :address
  after_validation :geocode

end
