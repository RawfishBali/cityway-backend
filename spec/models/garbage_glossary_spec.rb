# == Schema Information
#
# Table name: garbage_glossaries
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  utility_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe GarbageGlossary, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
