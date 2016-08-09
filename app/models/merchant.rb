# == Schema Information
#
# Table name: merchants
#
#  id                   :integer          not null, primary key
#  name                 :string           not null
#  address              :string           not null
#  phone                :string
#  email                :string
#  website              :string
#  facebook             :string
#  instagram            :string
#  description          :text
#  latitude             :float
#  longitude            :float
#  support_disabilities :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  city_id              :integer
#  category_id          :integer
#

class Merchant < ActiveRecord::Base
  has_and_belongs_to_many :subcategories, class_name: 'Category'
  belongs_to :category
  belongs_to :city

  
end
