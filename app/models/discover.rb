# == Schema Information
#
# Table name: discovers
#
#  id         :integer          not null, primary key
#  photo      :string
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Discover < ActiveRecord::Base
  belongs_to :city
  mount_uploader :photo, PhotoUploader
end
