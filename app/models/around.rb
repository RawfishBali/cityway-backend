# == Schema Information
#
# Table name: arounds
#
#  id         :integer          not null, primary key
#  photo      :string
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Around < ActiveRecord::Base
  belongs_to :city
  has_many :events , dependent: :destroy
  has_many :markets , dependent: :destroy
  has_many :parks , dependent: :destroy
  mount_uploader :photo, PhotoUploader

  def active_events
    events.where('event_start >= ?', Time.now).order('event_start ASC')
  end
end
