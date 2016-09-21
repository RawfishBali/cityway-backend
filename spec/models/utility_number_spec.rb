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
#

require 'rails_helper'

RSpec.describe UtilityNumber, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
