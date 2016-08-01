# == Schema Information
#
# Table name: client_applications
#
#  id         :integer          not null, primary key
#  name       :string
#  key        :string
#  secret     :string
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ClientApplicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
