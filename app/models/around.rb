# == Schema Information
#
# Table name: arounds
#
#  id          :integer          not null, primary key
#  description :string
#  photo       :string
#  city_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Around < ActiveRecord::Base
  belongs_to :city
  mount_uploader :photo, PhotoUploader
end
