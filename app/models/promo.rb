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
#

class Promo < ActiveRecord::Base
end
