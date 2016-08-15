# == Schema Information
#
# Table name: utilities
#
#  id          :integer          not null, primary key
#  description :string
#  photo       :string
#  city_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Utility < ActiveRecord::Base
  belongs_to :city
  mount_uploader :photo, PhotoUploader
end
