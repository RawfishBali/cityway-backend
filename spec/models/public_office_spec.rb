# == Schema Information
#
# Table name: public_offices
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  photo          :string
#  description    :text
#  email          :string
#  address        :string
#  phone          :string
#  fax            :string
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  website        :string
#  latitude       :float
#  longitude      :float
#

require 'rails_helper'

RSpec.describe PublicOffice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
