# == Schema Information
#
# Table name: cities
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  latitude    :float            not null
#  longitude   :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  photo       :string
#

class City < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  has_many :merchants, dependent: :destroy

  geocoded_by :name
  after_validation :geocode

  mount_uploader :photo, PhotoUploader
end
