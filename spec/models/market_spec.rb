# == Schema Information
#
# Table name: markets
#
#  id                   :integer          not null, primary key
#  name                 :string           not null
#  address              :string           not null
#  latitude             :float
#  longitude            :float
#  description          :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  around_id            :integer
#  support_disabilities :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe Market, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
