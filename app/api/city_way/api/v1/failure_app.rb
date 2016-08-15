module CityWay
  module Api
    module V1
      class FailureApp
        def self.call(env)
          new.call(env)
        end

        def call(env)
          warden = env['warden']
          strategy = warden.winning_strategy
          unless strategy
            strategy = OpenStruct.new(message: "Unauthorized", scope: nil, error_status: 401)
          end

          body = '{"error":"' + strategy.message.to_s + '"}'
          status = strategy.error_status rescue 401
          headers = {'Content-Type' => 'application/json'}

          headers['X-Accepted-OAuth-Scopes'] = (strategy.scope || :public).to_s

          [status, headers, [body]]
        end
      end
    end
  end
end
