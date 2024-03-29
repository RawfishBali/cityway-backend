# == Schema Information
#
# Table name: schools
#
#  id                   :integer          not null, primary key
#  name                 :string
#  denomination         :string
#  description          :text
#  address              :string
#  latitude             :float
#  longitude            :float
#  email                :string
#  phone                :string
#  school_type          :string
#  is_public            :boolean
#  website              :string
#  commercial           :boolean
#  utility_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  support_disabilities :boolean          default(FALSE)
#  facebook             :string
#  instagram            :string
#  twitter              :string
#  google_plus          :string
#  phone_1              :string
#  phone_2              :string
#

require 'rails_helper'

RSpec.describe School, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
