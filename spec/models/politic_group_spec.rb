# == Schema Information
#
# Table name: politic_groups
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe PoliticGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
