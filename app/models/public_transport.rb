# == Schema Information
#
# Table name: public_transports
#
#  id             :integer          not null, primary key
#  name           :string
#  attachment     :string
#  transport_type :integer
#  path           :text
#  utility_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PublicTransport < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader

  enum transport_type: [:bus, :regional_bus, :autobus, :tram, :underground]

  belongs_to :utility
end
