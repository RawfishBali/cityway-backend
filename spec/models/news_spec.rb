# == Schema Information
#
# Table name: news
#
#  id             :integer          not null, primary key
#  title          :string           not null
#  photo          :string
#  published_at   :datetime         not null
#  description    :text             not null
#  commonplace_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  url            :string
#

require 'rails_helper'

RSpec.describe News, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
