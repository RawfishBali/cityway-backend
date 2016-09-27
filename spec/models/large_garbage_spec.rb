# == Schema Information
#
# Table name: large_garbages
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  address     :string           not null
#  latitude    :float
#  longitude   :float
#  phone       :string
#  website     :string
#  email       :string
#  description :text
#  utility_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe LargeGarbage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
