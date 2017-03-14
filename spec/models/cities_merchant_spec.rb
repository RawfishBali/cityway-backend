# == Schema Information
#
# Table name: cities_merchants
#
#  id          :integer          not null, primary key
#  city_id     :integer
#  merchant_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe CitiesMerchant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
