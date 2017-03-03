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
#  phone_1                :string
#  phone_2                :string
#  is_vice_major          :boolean          default(FALSE)
#

class Profile < ActiveRecord::Base
  belongs_to :commonplace
  belongs_to :politic_group
  validate :only_one_major
  validate :only_one_vice_major
  validate :major_is_not_vice

  validates_presence_of :name

  mount_base64_uploader :photo, PhotoUploader
  mount_base64_uploader :major_icon, PhotoUploader

  geocoded_by :address
  after_validation :geocode

  phony_normalize :phone, default_country_code: 'IT'
  validates :phone, phony_plausible: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true

  def only_one_major
    if self.new_record?
      if self.commonplace.major && self.is_major
        errors.add(:is_major, "only one major is allowed")
      end
    else
      if self.commonplace.major && self.is_major
        if self.commonplace.major.id != self.id
          errors.add(:is_major, "only one major is allowed")
        end
      end
    end

  end

  def only_one_vice_major
    if self.new_record?
      if self.commonplace.vice_major && self.is_vice_major
        errors.add(:is_vice_major, "only one vice major is allowed")
      end
    else
      if self.commonplace.vice_major && self.is_vice_major
        if self.commonplace.vice_major.id !=  self.id
          errors.add(:is_vice_major, "only one vice major is allowed")
        end
      end
    end

  end

  def major_is_not_vice
    if self.is_major && self.is_vice_major
      errors.add(:is_vice_major, "vice major can't be the major")
    end
  end
end
