# == Schema Information
#
# Table name: discovers
#
#  id         :integer          not null, primary key
#  photo      :string
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Discover < ActiveRecord::Base
  belongs_to :city

  has_many :places
  has_many :culinaries
  has_many :itineraries
  has_one :story

  mount_base64_uploader :photo, PhotoUploader

  def place_by_type place_type
    return [] if (Place.place_types[place_type]).blank?
    places.where("place_type = ?",Place.place_types[place_type])
  end

  def culinary_by_type culinary_type
    return [] if (Culinary.culinary_types[culinary_type]).blank?
    culinaries.where("culinary_type = ?",Culinary.culinary_types[culinary_type])
  end
end
