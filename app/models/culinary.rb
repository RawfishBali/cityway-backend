# == Schema Information
#
# Table name: culinaries
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  description   :text
#  discover_id   :integer
#  culinary_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Culinary < ActiveRecord::Base
  enum culinary_type: [:traditional, :grastonomy]

  belongs_to :discover

  validates_presence_of :discover
  validates_presence_of :name
end
