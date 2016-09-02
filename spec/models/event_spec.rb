# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  title                :string           not null
#  photo                :string           not null
#  address              :string           not null
#  latitude             :float
#  longitude            :float
#  website              :string
#  email                :string
#  facebook             :string
#  instagram            :string
#  support_disabilities :boolean          default(FALSE)
#  description          :text
#  event_start          :datetime         not null
#  around_id            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
