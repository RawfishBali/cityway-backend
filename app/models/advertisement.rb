# == Schema Information
#
# Table name: advertisements
#
#  id         :integer          not null, primary key
#  photo      :string
#  active     :boolean          default(FALSE)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sections   :string           is an Array
#  name       :string
#  url        :string
#

class Advertisement < ActiveRecord::Base
  has_and_belongs_to_many :cities, through: :advertisements_cities
  has_many :advertisements_cities, dependent: :destroy

  has_many :advertisement_durations, dependent: :destroy
  accepts_nested_attributes_for :advertisement_durations, reject_if: :all_blank, allow_destroy: true
  validates :photo, presence: true
  validates_format_of :url, with: URI::regexp(%w(http https)), allow_blank: true

  mount_base64_uploader :photo, PhotoUploader

  enum position: {
    'top': 0,
    'bottom': 1,
    'both': 2
  }

  def active?
    advertisement_durations.each do |advertisement_duration|
      return true if advertisement_duration.start_date <= Date.today && advertisement_duration.end_date >= Date.today
    end
    false
  end
end
