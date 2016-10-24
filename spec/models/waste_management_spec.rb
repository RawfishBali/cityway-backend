# == Schema Information
#
# Table name: waste_managements
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  phone              :string
#  website            :string
#  description        :text
#  delivered_together :boolean          default(FALSE)
#  utility_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  address            :string
#  latitude           :float
#  longitude          :float
#

require 'rails_helper'

RSpec.describe WasteManagement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
