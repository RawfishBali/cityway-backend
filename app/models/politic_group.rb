# == Schema Information
#
# Table name: politic_groups
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PoliticGroup < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :commonplace

  has_many :profiles , dependent: :destroy
  accepts_nested_attributes_for :profiles, reject_if: :all_blank, allow_destroy: true
  belongs_to :commonplace
end
