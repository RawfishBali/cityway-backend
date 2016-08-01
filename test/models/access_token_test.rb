# == Schema Information
#
# Table name: access_tokens
#
#  id                    :integer          not null, primary key
#  token                 :string
#  expired_at            :datetime
#  client_application_id :integer
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class AccessTokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
