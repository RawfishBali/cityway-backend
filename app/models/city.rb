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
  has_many :advertisements_cities, dependent: :destroy
  has_many :categories, through: :categories_cities
  has_many :categories_cities, dependent: :destroy
  has_one :around, dependent: :destroy
  has_one :commonplace, dependent: :destroy
  has_one :discover, dependent: :destroy
  has_one :utility, dependent: :destroy
  has_many :promos, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :description
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

  mount_base64_uploader :photo, PhotoUploader

  accepts_nested_attributes_for :around, :commonplace, :discover, :utility,  allow_destroy: true

  def active_advertisements
    advertisements.where('( (start_date <= ? and end_date >= ?) or (second_start_date <= ? and second_end_date >= ?) )', Time.now, Time.now, Time.now, Time.now).group_by(&:position)
  end

  def parent_categories
    categories.where(parent_id: nil).order('Name ASC')
  end

  def sorted_categories
    categories.includes(:categories_cities).parent_categories.order('categories_cities.priority ASC')
  end

end
