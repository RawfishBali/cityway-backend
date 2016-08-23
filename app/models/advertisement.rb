# == Schema Information
#
# Table name: advertisements
#
#  id         :integer          not null, primary key
#  photo      :string
#  active     :boolean          default(FALSE)
#  position   :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Advertisement < ActiveRecord::Base
  has_and_belongs_to_many :cities, through: :advertisements_cities
  has_many :advertisements_cities
  validates :photo, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  mount_uploader :photo, PhotoUploader

  enum position: {
    'top': 0,
    'bottom': 1
  }
end
