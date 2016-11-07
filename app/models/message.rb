# == Schema Information
#
# Table name: messages
#
#  id             :integer          not null, primary key
#  firstname      :string
#  lastname       :string
#  email          :string
#  message_type   :integer          not null
#  message        :text             not null
#  commonplace_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Message < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :message
  validates_presence_of :message_type

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  belongs_to :commonplace

  after_create :send_message

  def send_message
    MessageMailer.post_message(self).deliver_now
  end
end
