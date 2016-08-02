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
              error!({error: "User already exist"}, 400) and return if user
              user = User.new(email: params[:email], password: params[:password])

              if user.save
                token = current_client.access_tokens.where(user: user).first_or_create
                present token, with: CityView::Api::V1::Entities::AccessToken
              else
                return error!({error: user.errors.full_messages}, 400)
              end
            end

            desc "Sign Up With Facebook"
            params do
              requires :auth, type: Hash do
                requires :uid, type: String, desc: "Facebook Uid"
                requires :info, type: Hash do
                  requires :email, type: String, desc: "Facebook Email"
                  requires :verified_email, type: String, desc: "Facebook verified_email Email"
                  requires :verified, type: Boolean, desc: "Facebook verified boolean"
                  optional :nickname, type: String, desc: "Facebook nickname"
                end
                optional :extra, type: Hash do
                  optional :raw_info, type: Hash do
                    optional :name, type: String, desc: "Facebook Name"
                  end
                end
                requires :provider, type: String, desc: "Oauth Provider"
              end
            end
            post :facebook do
              signed_in_resource = User.find_by(email: params[:auth][:info][:email]) || nil
              user = User.find_for_oauth(params[:auth], signed_in_resource)

              error!({error: "Failed Authentication With Facebook"}, 400) and return unless user

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

              error!({error: "Invalid email or password"}, 400) and return unless user

              token = current_client.access_tokens.where(user: user).first_or_create

              present token, with: CityView::Api::V1::Entities::AccessToken
            end

            desc "Refresh access token"
            params do
              requires :refresh_token, type: String, desc: "refresh_token"
            end
            post :token do
              access_token = AccessToken.find_by(refresh_token: params[:refresh_token])
              error!({error: "Invalid Refresh Token"}, 400) and return unless access_token

              access_token.refresh_token_if_expired

              present access_token, with: CityView::Api::V1::Entities::AccessToken
            end
          end




        end
      end
    end
  end
end
