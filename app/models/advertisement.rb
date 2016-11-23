# == Schema Information
#
# Table name: advertisements
#
#  id                :integer          not null, primary key
#  photo             :string
#  active            :boolean          default(FALSE)
#  position          :integer
#  start_date        :datetime
#  end_date          :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  second_start_date :datetime
#  second_end_date   :datetime
#

class Advertisement < ActiveRecord::Base
  has_and_belongs_to_many :cities, through: :advertisements_cities
  has_many :advertisements_cities
  validates :photo, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  mount_base64_uploader :photo, PhotoUploader

  enum position: {
    'top': 0,
    'bottom': 1,
    'both': 2
  }

  def active?
    start_date <= Time.now && end_date >= Time.now
  end
end
