# == Schema Information
#
# Table name: taxis
#
#  id           :integer          not null, primary key
#  contact_name :string
#  phone_number :string
#  website      :string
#  utility_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  address      :string
#  latitude     :float
#  longitude    :float
#

class Taxi < ActiveRecord::Base
  belongs_to :utility

  geocoded_by :address
  after_validation :geocode
end
