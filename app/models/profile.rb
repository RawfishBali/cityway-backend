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
#  city_hall_name         :string
#  major_icon             :string
#

class Profile < ActiveRecord::Base
  belongs_to :commonplace
  belongs_to :politic_group
  validate :only_one_major

  validates_presence_of :name

  mount_base64_uploader :photo, PhotoUploader
  mount_base64_uploader :major_icon, PhotoUploader

  geocoded_by :address
  after_validation :geocode

  def only_one_major
    if self.commonplace.major && self.is_major && self.new_record?
      errors.add(:is_major, "only one major is allowed")
    end
  end
end
