# == Schema Information
#
# Table name: coordinates
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  ztl_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Coordinate < ActiveRecord::Base
  belongs_to :ztl

  validates_presence_of :latitude , :longitude
end
