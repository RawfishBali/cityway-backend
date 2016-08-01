# == Schema Information
#
# Table name: client_applications
#
#  id         :integer          not null, primary key
#  name       :string
#  key        :string
#  secret     :string
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClientApplication < ActiveRecord::Base
  validates :name, presence: true
  validates :key, presence: true
  validates :secret, presence: true

  after_initialize :set_default_value

  has_many :access_tokens

  def set_default_value
    self.key = SecureRandom.urlsafe_base64(20) unless self.key
    self.secret = SecureRandom.urlsafe_base64(20) unless self.secret
  end

  # REQUIRED
  def self.locate(client_id, client_secret = nil)
    begin
      ClientApplication.find_by(key: client_id, secret: client_secret) if client_id.present? and client_secret.present?
    rescue Encoding::UndefinedConversionError => e
      nil
    end
  end

  def generate_key_and_secret_for_basic_auth
    Base64.urlsafe_encode64 self.key + ':' + self.secret
  end

  # OPTIONAL
  def scope?(scope)
    [:client].include? skope
  end
end
