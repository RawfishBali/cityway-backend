# == Schema Information
#
# Table name: news
#
#  id             :integer          not null, primary key
#  title          :string           not null
#  photo          :string
#  published_at   :datetime         not null
#  commonplace_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  url            :string
#

class News < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :published_at

  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

  belongs_to :commonplace
  mount_uploader :photo, PhotoUploader

  def primary_photo
    primary_photo = photos.where(is_primary: true).limit(1)
    if primary_photo.length > 0
      primary_photo
    else
      [photos.first]
    end
  end
end
