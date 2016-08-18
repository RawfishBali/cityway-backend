# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  firstname              :string
#  lastname               :string
#  newsletter             :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # has_secure_password

  has_many :access_tokens
  # has_and_belongs_to_many :client_applications

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_oauth(uid,email, firstname,lastname, newsletter = false, signed_in_resource = nil)


    identity = Identity.find_for_oauth(uid)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      user = User.where(:email => email).first

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
        email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
        firstname: firstname,
        lastname: lastname,
        newsletter: newsletter,
        password: Devise.friendly_token[0,20]
        )
        user.save!
      end
    else
      user.update(newsletter: newsletter) if newsletter
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end


  def self.authenticate(email, password)
    user = User.find_for_authentication(:email => email)
    user and user.valid_password?(password) ? user : nil
  end
end
