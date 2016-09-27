# == Schema Information
#
# Table name: utility_places
#
#  id             :integer          not null, primary key
#  name           :string
#  denomination   :string
#  description    :text
#  address        :string
#  latitude       :float
#  longitude      :float
#  email          :string
#  phone          :string
#  place_type     :integer
#  visitable_id   :integer
#  visitable_type :string
#  is_public      :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  website        :string
#
# UtilityPlace.create(name: 'Farmacia Centrale Valeri', description: 'Farmacia Centrale Valeri', address: ' Corso Andrea Palladio, 136, 36100 Vicenza VI, Italy', phone: '+39 0444 321964' , place_type: 'pharmacies', visitable_id: 14, visitable_type: 'Utility')

class UtilityPlace < ActiveRecord::Base
  enum place_type: [:post_office , :pharmacies, :water_house, :waste_recycling, :bikes, :public_swimming_pool, :tennis_court, :stadium, :structures, :social_services, :voluntary_association, :elder_home, :young_people_place, :kindergardern, :primary_school, :first_secondary_school, :second_secondary_school, :universities, :music]

  HAS_BUSINESSHOUR = ['voluntary_association', 'social_services', 'structures', 'tennis_court','public_swimming_pool', 'post_office', 'pharmacies']

  has_many :business_hours, as: :marketable, dependent: :destroy
  has_many :photos, as: :imageable, dependent: :destroy

  geocoded_by :address
  after_validation :geocode

  def primary_photo
    primary_photo = photos.where(is_primary: true).limit(1)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end

  def all_business_hours
    mb = (self.business_hours).to_a
    return mb if mb.size == 7
    ((0..6).to_a  - mb.map(&:day)).each do |m|
      mb << BusinessHour.new(morning_open_time: '00:00', morning_close_time: '00:00', evening_open_time: nil, evening_close_time: nil, day: m, marketable_type: self.class.name, marketable_id: self.id)
    end
    mb
  end

end
