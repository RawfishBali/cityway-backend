# == Schema Information
#
# Table name: cities_events
#
#  id         :integer          not null, primary key
#  city_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CitiesEvent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
