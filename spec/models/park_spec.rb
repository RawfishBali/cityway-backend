# == Schema Information
#
# Table name: parks
#
#  id                   :integer          not null, primary key
#  name                 :string
#  address              :string
#  latitude             :float
#  longitude            :float
#  support_disabilities :boolean
#  description          :text
#  around_id            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'rails_helper'

RSpec.describe Park, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
