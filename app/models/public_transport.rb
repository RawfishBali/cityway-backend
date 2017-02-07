# == Schema Information
#
# Table name: public_transports
#
#  id                   :integer          not null, primary key
#  name                 :string
#  attachment           :string
#  transport_type       :integer
#  utility_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  support_disabilities :boolean          default(FALSE)
#

class PublicTransport < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader

  enum transport_type: [:bus, :regional_bus, :autobus, :tram, :underground]

  has_many :paths, dependent: :destroy
  accepts_nested_attributes_for :paths, reject_if: :all_blank, allow_destroy: true

  belongs_to :utility
end
