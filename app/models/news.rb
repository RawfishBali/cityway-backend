# == Schema Information
#
# Table name: news
#
#  id             :integer          not null, primary key
#  title          :string           not null
#  photo          :string
#  published_at   :datetime         not null
#  description    :text             not null
#  commonplace_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  url            :string
#

class News < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :published_at

  belongs_to :commonplace
  mount_uploader :photo, PhotoUploader
end
