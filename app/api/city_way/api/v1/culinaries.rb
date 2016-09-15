module CityWay
  module Api
    module V1
      class Culinaries < Grape::API
        version 'v1'
        format :json

        resources :culinaries do
          before do
            authenticate!
          end

          desc "Culinary Detail"
          params do
            requires :id , type: Integer, values: -> { Culinary.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            culinary = Culinary.find(params[:id])
            present culinary, with: CityWay::Api::V1::Entities::Culinary, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end
        end
      end
    end
  end
end
