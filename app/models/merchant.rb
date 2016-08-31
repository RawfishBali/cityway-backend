# == Schema Information
#
# Table name: merchants
#
#  id                   :integer          not null, primary key
#  name                 :string           not null
#  address              :string           not null
#  phone                :string
#  email                :string
#  website              :string
#  facebook             :string
#  instagram            :string
#  description          :text
#  latitude             :float
#  longitude            :float
#  support_disabilities :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  city_id              :integer
#  category_id          :integer
#  photo                :string
#  icon                 :string
#

class Merchant < ActiveRecord::Base
  has_and_belongs_to_many :subcategories, class_name: 'Category'
  has_many :promos, dependent: :destroy
  has_many :business_hours, as: :marketable, dependent: :destroy
  has_many :photos, as: :imageable, dependent: :destroy
  belongs_to :category
  belongs_to :city

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :icon

  mount_uploader :icon, PhotoUploader

  geocoded_by :address
  after_validation :geocode
  after_create :create_default_business_hours

  def create_default_business_hours
    7.times do |i|
      self.business_hours << BusinessHour.create(day: i,morning_open_time: '00:00', morning_close_time: '00:00', evening_open_time: '00:00', evening_close_time: '00:00')
    end
  end

  def primary_photo
    photos.find_by(is_primary: true) || photos.first
  end
end
