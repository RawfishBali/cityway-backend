# == Schema Information
#
# Table name: city_hall_stories
#
#  id             :integer          not null, primary key
#  top_text       :text             not null
#  bottom_text    :text             not null
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  external_link  :string
#

require 'rails_helper'

RSpec.describe CityHallStory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
