# == Schema Information
#
# Table name: event_dates
#
#  id         :integer          not null, primary key
#  event_date :date
#  day_name   :string
#  open_time  :time
#  close_time :time
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe EventDate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
