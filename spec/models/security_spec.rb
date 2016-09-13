# == Schema Information
#
# Table name: securities
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  url            :string           not null
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Security, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
