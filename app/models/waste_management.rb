# == Schema Information
#
# Table name: waste_managements
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  phone              :string
#  website            :string
#  description        :text
#  delivered_together :boolean          default(FALSE)
#  utility_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  address            :string
#  latitude           :float
#  longitude          :float
#  is_domestic        :boolean          default(TRUE)
#

class WasteManagement < ActiveRecord::Base
  belongs_to :utility
  has_many :waste_pickup_schedules
  accepts_nested_attributes_for :waste_pickup_schedules, reject_if: :all_blank, allow_destroy: true

  geocoded_by :address
  after_validation :geocode

  validate :only_one_waste_management_per_city

  phony_normalize :phone, default_country_code: 'IT'
  validates :phone, phony_plausible: true

  def only_one_waste_management_per_city
    existed = WasteManagement.find_by(utility_id: self.utility_id, is_domestic: self.is_domestic)
    errors.add(:is_domestic, "only one waste_management per city") if existed && existed.id != self.id
  end

end
