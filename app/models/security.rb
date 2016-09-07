# == Schema Information
#
# Table name: securities
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  url            :string           not null
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Security < ActiveRecord::Base
  belongs_to :commonplace

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :commonplace
end
