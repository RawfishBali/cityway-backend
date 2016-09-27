# == Schema Information
#
# Table name: profiles
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  role                   :string
#  phone                  :string
#  fax                    :string
#  days_open              :integer          is an Array
#  appointment_start      :time
#  appointment_end        :time
#  photo                  :string
#  is_major               :boolean          default(FALSE)
#  is_city_council_member :boolean          default(FALSE)
#  politic_group_id       :integer
#  commonplace_id         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  address                :string
#  latitude               :float
#  longitude              :float
#  website                :string
#  description            :text
#  email                  :string
#

class Profile < ActiveRecord::Base
  belongs_to :commonplace
  belongs_to :politic_group

  validates_presence_of :name
  validates_presence_of :commonplace

  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode
end
