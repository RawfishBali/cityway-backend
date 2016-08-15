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
  has_one :around
  has_one :commonplace
  has_one :discover
  has_one :utility

  geocoded_by :name
  after_validation :geocode

  mount_uploader :photo, PhotoUploader

  accepts_nested_attributes_for :around, :commonplace, :discover, :utility,  allow_destroy: true
end
