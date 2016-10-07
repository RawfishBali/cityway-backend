# == Schema Information
#
# Table name: certificates
#
#  id             :integer          not null, primary key
#  name           :string
#  url            :string
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Certificate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
