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
              requires :grant_type, type: String, desc: "Grant Type", values: ['password']
              requires :scope, type: String, desc: "Scope", values: ['offline_access']
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
          end

          # desc "Sign Up With Facebook"
          # params do
          #   requires :email, type: String, desc: "email"
          #   requires :password, type: String, desc: "Password"
          #   requires :grant_type, type: String, desc: "Grant Type", values: ['password']
          #   requires :scope, type: String, desc: "Scope", values: ['offline_access']
          # end
          # post :facebook do
          #   user = User.find_for_oauth(auth, signed_in_resource = nil)
          #   # user = User.find_by(email: params[:username]).try(:authenticate, params[:password])
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
