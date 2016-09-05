# == Schema Information
#
# Table name: markets
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  address     :string           not null
#  latitude    :float
#  longitude   :float
#  open_time   :time             not null
#  close_time  :time             not null
#  description :text
#  day_opens   :integer          is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Market, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
