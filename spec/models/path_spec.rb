# == Schema Information
#
# Table name: paths
#
#  id                  :integer          not null, primary key
#  path                :text             not null
#  public_transport_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Path, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
