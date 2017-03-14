# == Schema Information
#
# Table name: ztls
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  utility_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  color       :string           default("#7FB1B6")
#

class Ztl < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  belongs_to :utility

  has_many :coordinates
  accepts_nested_attributes_for :coordinates, reject_if: :all_blank, allow_destroy: true
end
