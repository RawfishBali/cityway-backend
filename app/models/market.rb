# == Schema Information
#
# Table name: markets
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  address     :string           not null
#  latitude    :float
#  longitude   :float
#  open_time   :time             not null
#  close_time  :time             not null
#  description :text
#  day_opens   :integer          is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Market < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :open_time
  validates_presence_of :close_time
  validates_inclusion_of :day_opens, in: 0..6

  has_many :photos, as: :imageable, dependent: :destroy
end
