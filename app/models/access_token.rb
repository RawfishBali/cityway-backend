# == Schema Information
#
# Table name: access_tokens
#
#  id                    :integer          not null, primary key
#  token                 :string
#  expired_at            :datetime
#  client_application_id :integer
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  refresh_token         :string
#

class AccessToken < ActiveRecord::Base
	belongs_to :client_application
	belongs_to :user

	before_create :generate_access_token
	before_create :generate_refresh_token
	before_create :set_expiration

	def self.locate(token_string)
		self.find_by token: token_string
	end

	# OPTIONAL
	def expired?
		# Never Expired Token Hahaha
		# DateTime.now >= self.expired_at
		false
	end

	# OPTIONAL
	def scope?(skope)
		[:offline_access].include? skope
	end

	def refresh_token_if_expired
		if expired?
			generate_refresh_token
			set_expiration
			self.save
			self
		end
	end


	def expired_in_seconds
		Time.now < self.expired_at ? time_diff_in_natural_language(Time.now, self.expired_at).to_i : 0
	end

	def time_diff_in_natural_language(from_time, to_time)
		from_time = from_time.to_time if from_time.respond_to?(:to_time)
		to_time = to_time.to_time if to_time.respond_to?(:to_time)
		distance_in_seconds = ((to_time - from_time).abs).round
		components = []

		%w(second).each do |interval|
			# For each interval type, if the amount of time remaining is greater than
			# one unit, calculate how many units fit into the remaining time.
			if distance_in_seconds >= 1.send(interval)
				delta = (distance_in_seconds / 1.send(interval)).floor
				distance_in_seconds -= delta.send(interval)
				components << delta
			end
		end

		components.join(", ")
	end

	private
	def generate_access_token
		begin
			self.token = SecureRandom.hex
		end while self.class.exists?(token: token)
	end

	def generate_refresh_token
		begin
			self.refresh_token = SecureRandom.hex
		end while self.class.exists?(refresh_token: refresh_token)
	end

	def set_expiration
		self.expired_at = DateTime.now + 100.years
	end
end
