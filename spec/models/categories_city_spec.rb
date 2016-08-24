# == Schema Information
#
# Table name: categories_cities
#
#  id          :integer          not null, primary key
#  city_id     :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe CategoriesCity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
