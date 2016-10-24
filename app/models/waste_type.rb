# == Schema Information
#
# Table name: waste_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  icon       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WasteType < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :icon
  
  mount_uploader :icon, PhotoUploader
end
