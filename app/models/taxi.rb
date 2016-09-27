# == Schema Information
#
# Table name: taxis
#
#  id           :integer          not null, primary key
#  contact_name :string
#  phone_number :string
#  website      :string
#  utility_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Taxi < ActiveRecord::Base
  belongs_to :utility
end
