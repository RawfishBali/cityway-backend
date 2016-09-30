# == Schema Information
#
# Table name: paths
#
#  id                  :integer          not null, primary key
#  path                :text             not null
#  public_transport_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Path < ActiveRecord::Base
  belongs_to :public_transport

  validates_presence_of :path
  validates_presence_of :public_transport
end
