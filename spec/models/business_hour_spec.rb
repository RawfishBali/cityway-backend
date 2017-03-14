# == Schema Information
#
# Table name: business_hours
#
#  id                 :integer          not null, primary key
#  day                :integer          not null
#  morning_open_time  :time
#  morning_close_time :time
#  evening_open_time  :time
#  evening_close_time :time
#  open_all_day       :boolean          default(FALSE)
#  marketable_id      :integer
#  marketable_type    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_open_today      :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe BusinessHour, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
