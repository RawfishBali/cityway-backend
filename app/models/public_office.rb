# == Schema Information
#
# Table name: public_offices
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  photo          :string
#  description    :text
#  email          :string
#  address        :string
#  phone          :string
#  fax            :string
#  days_open      :integer          is an Array
#  open_time      :time
#  close_time     :time
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PublicOffice < ActiveRecord::Base
  validates_presence_of :name
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :save }

  belongs_to :commonplace

  mount_uploader :photo, PhotoUploader
end
