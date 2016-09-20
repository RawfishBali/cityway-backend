# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  address     :string
#  latitude    :float
#  longitude   :float
#  email       :string
#  website     :string
#  facebook    :string
#  instagram   :string
#  twitter     :string
#  google_plus :string
#  discover_id :integer
#  place_type  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Place, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end