# == Schema Information
#
# Table name: garbage_glossaries
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  utility_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GarbageGlossary < ActiveRecord::Base
  belongs_to :utility

  validates_presence_of :name, :description
end
