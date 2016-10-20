# == Schema Information
#
# Table name: categories_cities
#
#  id          :integer          not null, primary key
#  city_id     :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  priority    :integer          default(0)
#

class CategoriesCity < ActiveRecord::Base
  belongs_to :category
  belongs_to :city
end
