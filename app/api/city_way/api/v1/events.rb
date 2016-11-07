module CityWay
  module Api
    module V1
      class Events < Grape::API
        version 'v1'
        format :json

        resources :events do
          before do
            authenticate!
          end

          desc "Event Detail"
          params do
            requires :id , type: Integer, values: -> { Event.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            event = Event.find(params[:id])
            present event, with: CityWay::Api::V1::Entities::Event, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end
        end
      end
    end
  end
end