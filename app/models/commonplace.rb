# == Schema Information
#
# Table name: commonplaces
#
#  id          :integer          not null, primary key
#  photo       :string
#  icon        :string
#  city_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  history     :text
#  facebook    :string
#  instagram   :string
#  twitter     :string
#  google_plus :string
#

class Commonplace < ActiveRecord::Base
  has_many :news , dependent: :destroy
  
  belongs_to :city
  mount_uploader :photo, PhotoUploader
  mount_uploader :icon, PhotoUploader
end
