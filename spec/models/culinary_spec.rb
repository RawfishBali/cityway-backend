# == Schema Information
#
# Table name: culinaries
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  description   :text
#  discover_id   :integer
#  culinary_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Culinary, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
