module CityWay
  module Api
    module V1
      class Itineraries < Grape::API
        version 'v1'
        format :json

        resources :itineraries do
          before do
            authenticate!
          end

          desc "Itinerary Detail"
          params do
            requires :id , type: Integer, values: -> { Itinerary.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            itinerary = Itinerary.find(params[:id])
            present itinerary, with: CityWay::Api::V1::Entities::Itinerary, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end
        end
      end
    end
  end
end
