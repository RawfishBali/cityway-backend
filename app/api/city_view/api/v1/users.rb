module CityView
  module Api
    module V1
      class Users < Grape::API
        version 'v1', using: :path do
          format :json

          resources :users do
            before do
              authenticate!
            end

            helpers do
              def current_client
                authenticate!
              end
            end

            desc "Sign Up With Email"
            params do
              requires :email, type: String, desc: "email"
              requires :password, type: String, desc: "Password"
              requires :password_confirmation, type: String, desc: "Password Confirmation"
            end
            post :sign_up do
              error!({error: "Password and password_confirmation doesn't match"}, 400) and return if params[:password] != params[:password_confirmation]

              user =  User.find_by(email: params[:email])
              error!({error: "User already exist"}, 401) and return if user
              user = User.new(email: params[:email], password: params[:password])

              if user.save
                token = current_client.access_tokens.where(user: user).first_or_create
                present token, with: CityView::Api::V1::Entities::AccessToken
              else
                return error!({error: user.errors.full_messages}, 401)
              end
            end

            desc "Sign Up With Facebook"
            params do
              requires :email, type: String, desc: "Facebook Email"
              requires :uid, type: String, desc: "Facebook Uid"

            end
            post :facebook do
              signed_in_resource = User.find_by(email: params[:email]) || nil
              user = User.find_for_oauth(params[:uid], signed_in_resource)

              error!({error: "Failed Authentication With Facebook"}, 401) and return unless user

              token = current_client.access_tokens.where(user: user).first_or_create

              present token, with: CityView::Api::V1::Entities::AccessToken
            end

            desc "Sign In With Email"
            params do
              requires :email, type: String, desc: "email"
              requires :password, type: String, desc: "Password"
            end
            post :sign_in do
              user = User.authenticate(params[:email],params[:password])

              error!({error: "Invalid email or password"}, 401) and return unless user

              token = current_client.access_tokens.where(user: user).first_or_create

              present token, with: CityView::Api::V1::Entities::AccessToken
            end

            desc "Refresh access token"
            params do
              requires :refresh_token, type: String, desc: "refresh_token"
            end
            post :token do
              access_token = AccessToken.find_by(refresh_token: params[:refresh_token])
              error!({error: "Invalid Refresh Token"}, 401) and return unless access_token

              access_token.refresh_token_if_expired

              present access_token, with: CityView::Api::V1::Entities::AccessToken
            end
          end




        end
      end
    end
  end
end
