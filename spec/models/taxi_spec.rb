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
#  address      :string
#  latitude     :float
#  longitude    :float
#

require 'rails_helper'

RSpec.describe Taxi, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
