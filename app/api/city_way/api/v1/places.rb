module CityWay
  module Api
    module V1
      class Places < Grape::API
        version 'v1'
        format :json

        resources :places do
          before do
            authenticate!
          end

          desc "Place Detail"
          params do
            requires :id , type: Integer, values: -> { Place.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            place = Place.find(params[:id])
            present place, with: CityWay::Api::V1::Entities::Place, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end
        end
      end
    end
  end
end
