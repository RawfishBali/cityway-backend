# == Schema Information
#
# Table name: commonplaces
#
#  id          :integer          not null, primary key
#  description :string
#  photo       :string
#  icon        :string
#  city_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Commonplace < ActiveRecord::Base
  belongs_to :city
  mount_uploader :photo, PhotoUploader
  mount_uploader :icon, PhotoUploader
end
