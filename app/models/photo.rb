# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  picture        :string
#  imageable_id   :integer
#  imageable_type :string
#  is_primary     :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  position       :integer
#

class Photo < ActiveRecord::Base
  enum position: [:top, :middle, :bottom]
  mount_base64_uploader :picture, PhotoUploader
end
