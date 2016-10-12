# == Schema Information
#
# Table name: stories
#
#  id            :integer          not null, primary key
#  top_text      :text
#  bottom_text   :text
#  discover_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  external_link :string
#

class Story < ActiveRecord::Base
  has_many :photos, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

  belongs_to :discover

  validates_presence_of :discover
end
