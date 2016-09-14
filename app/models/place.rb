# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  address     :string
#  latitude    :float
#  longitude   :float
#  email       :string
#  website     :string
#  facebook    :string
#  instagram   :string
#  twitter     :string
#  google_plus :string
#  discover_id :integer
#  place_type  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Place < ActiveRecord::Base
  enum place_type: [:monument, :library, :theater, :museum, :cinema]

  has_many :business_hours, as: :marketable, dependent: :destroy
  belongs_to :discover

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :description
  validates_presence_of :place_type

  geocoded_by :address
  after_validation :geocode

end
