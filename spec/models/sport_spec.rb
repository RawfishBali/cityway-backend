# == Schema Information
#
# Table name: sports
#
#  id           :integer          not null, primary key
#  name         :string
#  denomination :string
#  description  :text
#  address      :string
#  latitude     :float
#  longitude    :float
#  email        :string
#  phone        :string
#  sport_type   :string
#  is_public    :boolean
#  website      :string
#  commercial   :boolean
#  utility_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  phone_1      :string
#  phone_2      :string
#

require 'rails_helper'

RSpec.describe Sport, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
