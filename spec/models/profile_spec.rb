# == Schema Information
#
# Table name: profiles
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  role                   :string
#  emails                 :string           is an Array
#  phone                  :string
#  fax                    :string
#  days_open              :integer          is an Array
#  appointment_start      :time
#  appointment_end        :time
#  photo                  :string
#  is_major               :boolean          default(FALSE)
#  is_city_council_member :boolean          default(FALSE)
#  politic_group_id       :integer
#  commonplace_id         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end