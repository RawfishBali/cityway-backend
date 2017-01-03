# == Schema Information
#
# Table name: cities_merchants
#
#  id          :integer          not null, primary key
#  city_id     :integer          not null
#  merchant_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CitiesMerchant < ActiveRecord::Base
  belongs_to :city
  belongs_to :merchant
end
