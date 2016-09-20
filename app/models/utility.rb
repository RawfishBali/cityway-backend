# == Schema Information
#
# Table name: utilities
#
#  id         :integer          not null, primary key
#  photo      :string
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Utility < ActiveRecord::Base
  has_many :devices

  belongs_to :city
  mount_uploader :photo, PhotoUploader
end
