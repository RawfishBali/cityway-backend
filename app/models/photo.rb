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
#

class Photo < ActiveRecord::Base
  mount_uploader :picture, PhotoUploader
end
