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
#

class UtilityPlace < ActiveRecord::Base
  enum place_type: [:post_office , :pharmacies, :water_house, :waste_recycling, :bikes, :public_swimming_pool, :tennis_court, :stadium, :structures, :social_services, :voluntary_association, :elder_home, :young_people_place, :kindergardern, :primary_school, :first_secondary_school, :second_secondary_school, :universities, :music]

  HAS_BUSINESSHOUR = ['voluntary_association', 'social_services', 'structures', 'tennis_court','public_swimming_pool', 'post_office', 'pharmacies']

  has_many :business_hours, as: :marketable, dependent: :destroy
  has_many :photos, as: :imageable, dependent: :destroy

  after_create :create_default_business_hours

  def create_default_business_hours
    if UtilityPlace::HAS_BUSINESSHOUR.include? self.place_type
      7.times do |i|
        self.business_hours << BusinessHour.create(day: i,morning_open_time: '00:00', morning_close_time: '00:00', evening_open_time: '00:00', evening_close_time: '00:00')
      end
    end
  end

  def primary_photo
    primary_photo = photos.where(is_primary: true).limit(1)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end
end
