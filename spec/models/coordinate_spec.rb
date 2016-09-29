# == Schema Information
#
# Table name: coordinates
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  ztl_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Coordinate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
