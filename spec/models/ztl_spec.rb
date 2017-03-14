# == Schema Information
#
# Table name: ztls
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  utility_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  color       :string           default("#7FB1B6")
#

require 'rails_helper'

RSpec.describe Ztl, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
