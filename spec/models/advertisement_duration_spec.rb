# == Schema Information
#
# Table name: advertisement_durations
#
#  id               :integer          not null, primary key
#  start_date       :date
#  end_date         :date
#  advertisement_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe AdvertisementDuration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
