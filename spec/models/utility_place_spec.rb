# == Schema Information
#
# Table name: utility_places
#
#  id             :integer          not null, primary key
#  name           :string
#  denomination   :string
#  description    :text
#  address        :string
#  latitude       :float
#  longitude      :float
#  email          :string
#  phone          :string
#  place_type     :integer
#  visitable_id   :integer
#  visitable_type :string
#  is_public      :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  website        :string
#  commercial     :boolean
#

require 'rails_helper'

RSpec.describe UtilityPlace, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
