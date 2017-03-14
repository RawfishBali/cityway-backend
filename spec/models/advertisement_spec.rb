# == Schema Information
#
# Table name: advertisements
#
#  id         :integer          not null, primary key
#  photo      :string
#  active     :boolean          default(FALSE)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sections   :string           is an Array
#  name       :string
#  url        :string
#

require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
