# == Schema Information
#
# Table name: courses
#
#  id                   :integer          not null, primary key
#  name                 :string           not null
#  denomination         :string
#  description          :text
#  address              :string
#  latitude             :float
#  longitude            :float
#  email                :string
#  phone                :string
#  phone_1              :string
#  phone_2              :string
#  website              :string
#  utility_id           :integer
#  support_disabilities :boolean          default(FALSE)
#  facebook             :string
#  instagram            :string
#  twitter              :string
#  google_plus          :string
#  course_type          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
