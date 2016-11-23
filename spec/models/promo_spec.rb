# == Schema Information
#
# Table name: promos
#
#  id                   :integer          not null, primary key
#  title                :text
#  photo                :string
#  description          :text
#  terms_and_conditions :text
#  discount             :float
#  original_price       :float
#  discount_price       :float
#  merchant_id          :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  city_id              :integer
#  approval             :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe Promo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
