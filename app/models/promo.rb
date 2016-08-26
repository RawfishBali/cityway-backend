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
#  approval             :boolean          default(FALSE)
#

class Promo < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :photo
  validates_presence_of :description
  validates_presence_of :terms_and_conditions
  validates_presence_of :discount
  validates_presence_of :original_price
end
