# == Schema Information
#
# Table name: utility_numbers
#
#  id              :integer          not null, primary key
#  name            :string
#  local_number    :string
#  national_number :string
#  address         :string
#  utility_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  mobile_number   :string
#

class UtilityNumber < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :utility

  belongs_to :utility
end
