# == Schema Information
#
# Table name: commonplaces
#
#  id          :integer          not null, primary key
#  description :string
#  photo       :string
#  icon        :string
#  city_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Commonplace, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
