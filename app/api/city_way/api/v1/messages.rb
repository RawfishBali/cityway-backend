module CityWay
  module Api
    module V1
      class Messages < Grape::API
        version 'v1'
        format :json

        resources :messages do
          before do
            authenticate!
          end

          desc "Create Message"
          params do
            requires :firstname , type: String
            requires :lastname , type: String
            requires :message , type: String
            requires :email , type: String
            requires :message_type , type: Integer
            requires :city_hall_id , type: Integer
          end
          post do
            message = Message.new(firstname: params[:firstname], lastname: params[:lastname], email: params[:email], message_type: params[:message_type], message: params[:message], commonplace_id: params[:city_hall_id])
            message.save
            if message.errors.any?
              error!(message.errors.full_messages.to_sentence, 400)
            else
              present message, with: CityWay::Api::V1::Entities::Message
            end
          end
        end
      end
    end
  end
end
