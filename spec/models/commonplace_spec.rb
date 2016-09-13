# == Schema Information
#
# Table name: commonplaces
#
#  id          :integer          not null, primary key
#  photo       :string
#  icon        :string
#  city_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  history     :text
#  facebook    :string
#  instagram   :string
#  twitter     :string
#  google_plus :string
#

require 'rails_helper'

RSpec.describe Commonplace, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
