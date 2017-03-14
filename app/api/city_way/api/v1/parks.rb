module CityWay
  module Api
    module V1
      class Parks < Grape::API
        version 'v1'
        format :json

        resources :parks do
          before do
            authenticate!
          end

          desc "Park Detail"
          params do
            requires :id , type: Integer, values: -> { Park.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            park = Park.find(params[:id])
            present park, with: CityWay::Api::V1::Entities::Park, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

        end
      end
    end
  end
end
