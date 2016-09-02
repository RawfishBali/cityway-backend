# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  title                :string           not null
#  photo                :string           not null
#  address              :string           not null
#  latitude             :float
#  longitude            :float
#  website              :string
#  email                :string
#  facebook             :string
#  instagram            :string
#  support_disabilities :boolean          default(FALSE)
#  description          :text
#  event_start          :datetime         not null
#  around_id            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Event < ActiveRecord::Base

    belongs_to :around

    validates_presence_of :title
    validates_presence_of :address
    validates_presence_of :description
    validates_presence_of :event_start
    validates_presence_of :around
    validates_presence_of :photo

    geocoded_by :address
    after_validation :geocode

    mount_uploader :photo, PhotoUploader
     
end
