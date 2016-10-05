# == Schema Information
#
# Table name: online_services
#
#  id             :integer          not null, primary key
#  name           :string
#  url            :string
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class OnlineService < ActiveRecord::Base
  validates_presence_of :name, :url, :commonplace
  belongs_to :commonplace
end
