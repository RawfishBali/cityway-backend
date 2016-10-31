# == Schema Information
#
# Table name: city_hall_stories
#
#  id             :integer          not null, primary key
#  top_text       :text             not null
#  bottom_text    :text             not null
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class CityHallStory < ActiveRecord::Base
  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

  belongs_to :commonplace

  validates_presence_of :top_text
  validates_presence_of :bottom_text
  validates :photos, length: { minimum: 1 }

end
