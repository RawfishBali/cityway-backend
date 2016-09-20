# == Schema Information
#
# Table name: devices
#
#  id           :integer          not null, primary key
#  device_type  :integer
#  latitude     :float
#  longitude    :float
#  address      :string
#  external_url :string
#  utility_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Device, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
