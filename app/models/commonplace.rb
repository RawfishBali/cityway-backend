# == Schema Information
#
# Table name: commonplaces
#
#  id                    :integer          not null, primary key
#  photo                 :string
#  icon                  :string
#  city_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  history               :text
#  facebook              :string
#  instagram             :string
#  twitter               :string
#  google_plus           :string
#  phone                 :string
#  override_major        :boolean          default(FALSE)
#  contact_major_wording :string
#

class Commonplace < ActiveRecord::Base
  has_many :news , dependent: :destroy
  has_many :profiles , dependent: :destroy
  has_many :politic_groups , dependent: :destroy
  has_many :securities , dependent: :destroy
  has_many :public_offices , dependent: :destroy
  has_many :online_services , dependent: :destroy
  has_many :certificates , dependent: :destroy
  has_one :city_hall_story, dependent: :destroy

  belongs_to :city
  mount_base64_uploader :photo, PhotoUploader
  mount_base64_uploader :icon, PhotoUploader

  def major
    profiles.find_by(is_major: true)
  end

  def vice_major
    profiles.find_by(is_vice_major: true)
  end

  def city_councils
    profiles.where(is_city_council_member: true, is_vice_major: false, is_major: false)
  end

  def city_councils_with_vice_major
    profiles.where(is_city_council_member: true, politic_group_id: nil)
  end
end
