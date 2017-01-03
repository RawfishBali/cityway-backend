# == Schema Information
#
# Table name: advertisements
#
#  id                :integer          not null, primary key
#  photo             :string
#  active            :boolean          default(FALSE)
#  position          :integer
#  start_date        :datetime
#  end_date          :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  second_start_date :datetime
#  second_end_date   :datetime
#  sections          :string           is an Array
#

require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
