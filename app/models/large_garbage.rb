# == Schema Information
#
# Table name: large_garbages
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  address     :string           not null
#  latitude    :float
#  longitude   :float
#  phone       :string
#  website     :string
#  email       :string
#  description :text
#  utility_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LargeGarbage < ActiveRecord::Base
  has_many :business_hours, as: :marketable, dependent: :destroy

  geocoded_by :address
  after_validation :geocode
end
