# == Schema Information
#
# Table name: arounds
#
#  id         :integer          not null, primary key
#  photo      :string
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Around, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
