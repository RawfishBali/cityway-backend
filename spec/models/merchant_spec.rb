# == Schema Information
#
# Table name: merchants
#
#  id                   :integer          not null, primary key
#  name                 :string           not null
#  address              :string           not null
#  phone                :string
#  email                :string
#  website              :string
#  facebook             :string
#  instagram            :string
#  description          :text
#  latitude             :float
#  longitude            :float
#  support_disabilities :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  city_id              :integer
#  category_id          :integer
#  photo                :string
#  icon                 :string
#  twitter              :string
#  google_plus          :string
#  active               :boolean          default(TRUE)
#  activated_at         :datetime
#  deactivated_at       :datetime
#  secondary_phone      :string
#  is_basic             :boolean          default(FALSE)
#  open_all_day         :boolean          default(FALSE)
#  phone_extra          :string
#  admin_id             :integer
#

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
