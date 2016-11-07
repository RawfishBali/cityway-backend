# == Schema Information
#
# Table name: certificates
#
#  id             :integer          not null, primary key
#  name           :string
#  url            :string
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Certificate < ActiveRecord::Base
  belongs_to :commonplace

  validates_presence_of :name
  validates_presence_of :url
end
