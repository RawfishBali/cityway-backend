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

  has_many :merchants, dependent: :destroy
  has_and_belongs_to_many :advertisements, through: :advertisements_cities
  has_many :advertisements_cities
  has_one :around
  has_one :commonplace
  has_one :discover
  has_one :utility

  validates :name, presence: true
  validates :description, presence: true
  validates_presence_of :around
  validates_presence_of :commonplace
  validates_presence_of :discover
  validates_presence_of :utility

  geocoded_by :name
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results[1]
      obj.name    = geo.city
    end
  end

  mount_uploader :photo, PhotoUploader

  accepts_nested_attributes_for :around, :commonplace, :discover, :utility,  allow_destroy: true
end
