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
#

class WasteManagement < ActiveRecord::Base
  belongs_to :utility
  has_many :waste_pickup_schedules
  accepts_nested_attributes_for :waste_pickup_schedules, reject_if: :all_blank, allow_destroy: true

  geocoded_by :address
  after_validation :geocode

end
