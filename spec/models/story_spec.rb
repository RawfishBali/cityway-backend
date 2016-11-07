# == Schema Information
#
# Table name: stories
#
#  id            :integer          not null, primary key
#  top_text      :text
#  bottom_text   :text
#  discover_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  external_link :string
#

require 'rails_helper'

RSpec.describe Story, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
