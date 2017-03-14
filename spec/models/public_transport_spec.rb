# == Schema Information
#
# Table name: public_transports
#
#  id                   :integer          not null, primary key
#  name                 :string
#  attachment           :string
#  transport_type       :integer
#  utility_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  support_disabilities :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe PublicTransport, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
