module CityView
  module Api
    module V1
      class Token < Grape::API
        version 'v1', using: :path do
          format :json

          before do
            authenticate!
          end

          helpers do
            def current_client
              authenticate!
            end
          end

          desc "Request access token"
          params do
            requires :username, type: String, desc: "Username"
            requires :password, type: String, desc: "Password"
            requires :grant_type, type: String, desc: "Grant Type", values: ['password']
            requires :scope, type: String, desc: "Scope", values: ['offline_access']
          end
          post :token do
            user = User.find_by(email: params[:username]).try(:authenticate, params[:password])

            error!({error: "invalid_request"}, 400) and return unless user

            # unless current_client.client.users.include? user
            #
            # else
            #   return error!({error: "invalid_request"}, 400)
            # end

            puts "------------------"
            puts current_client.inspect
            puts "------------------"
            puts user.inspect
            puts "------------------"
            token = current_client.access_tokens.where(user: user).first_or_create

            present token, with: CityView::Api::V1::Entities::AccessToken
          end
        end
      end
    end
  end
end
