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

          # desc "Request access token"
          # params do
          #   requires :email, type: String, desc: "email"
          #   requires :password, type: String, desc: "Password"
          #   requires :grant_type, type: String, desc: "Grant Type", values: ['password']
          #   requires :scope, type: String, desc: "Scope", values: ['offline_access']
          # end
          # post :token do
          #   user = User.authenticate(params[:email],params[:password])
          #
          #   error!({error: "invalid_request"}, 400) and return unless user
          #
          #   token = current_client.access_tokens.where(user: user).first_or_create
          #
          #   present token, with: CityView::Api::V1::Entities::AccessToken
          # end
        end
      end
    end
  end
end
