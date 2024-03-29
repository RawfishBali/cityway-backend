module CityWay
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
              requires :firstname, type: String, desc: "firstname"
              requires :lastname, type: String, desc: "lastname"
              requires :newsletter, type: Boolean, desc: "newsletter"

            end
            post :sign_up do

              user =  User.find_by(email: params[:email])
              error!({error: "User already exist"}, 401) and return if user
              user = User.new(email: params[:email], password: params[:password], firstname: params[:firstname], lastname: params[:lastname], newsletter: params[:newsletter])

              if user.save
                token = current_client.access_tokens.where(user: user).first_or_create
                present token, with: CityWay::Api::V1::Entities::AccessToken
              else
                return error!({error: user.errors.full_messages}, 401)
              end
            end

            desc "Sign Up With Facebook"
            params do
              requires :email, type: String, desc: "Facebook Email"
              requires :uid, type: String, desc: "Facebook Uid"
              requires :firstname, type: String, desc: "firstname"
              requires :lastname, type: String, desc: "lastname"
              optional :newsletter, type: Boolean, desc: "newsletter setting"
            end
            post :facebook do
              signed_in_resource = User.find_by(email: params[:email]) || nil
              user = User.find_for_oauth(params[:uid], params[:email], params[:firstname], params[:lastname], (params[:newsletter] || false), signed_in_resource)

              error!({error: "Failed Authentication With Facebook"}, 401) and return unless user

              token = current_client.access_tokens.where(user: user).first_or_create

              present token, with: CityWay::Api::V1::Entities::AccessToken
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

              present token, with: CityWay::Api::V1::Entities::AccessToken
            end


            desc "Update User Newsletter"
            params do
              requires :newsletter, type: Boolean, desc: "newsletter"
            end
            put do
              unless current_user
                error!({error: "User doesn't exist"}, 401)
              else
                current_user.update(newsletter: params[:newsletter])
                present current_user, with: CityWay::Api::V1::Entities::User
              end
            end


            desc "Forgot password"
            params do
              requires :email, type: String, desc: "User's Email"
            end
            post :forgot_password do
              user = User.find_by(email: params[:email])
              unless user
                error!({error: "User doesn't exist"}, 401)
              else
                user.send_reset_password_instructions
                {message: "Reset Email Send To #{user.email} !"}
              end
            end

            desc "Show User"
            params do
            end
            get do
              unless current_user
                error!({error: "User doesn't exist"}, 401)
              else
                present current_user, with: CityWay::Api::V1::Entities::User
              end
            end
          end
        end
      end
    end
  end
end
