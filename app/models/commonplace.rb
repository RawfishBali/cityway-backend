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
  has_many :profiles , dependent: :destroy

  belongs_to :city
  mount_uploader :photo, PhotoUploader
  mount_uploader :icon, PhotoUploader

  def major
    profiles.find_by(is_major: true)
  end

  def city_councils
    profiles.where(is_city_council_member: true)
  end

  def politic_parties
    profiles.where(is_city_council_member: false).group(:political_group_id , :id)
  end
end
