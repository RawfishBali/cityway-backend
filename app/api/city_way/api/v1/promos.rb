module CityWay
  module Api
    module V1
      class Promos < Grape::API
        version 'v1'
        format :json

        resources :promos do
          before do
            authenticate!
          end

          desc "Promo Detail"
          params do
            requires :id , type: Integer, values: -> { Promo.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            merchant = Promo.find(params[:id])
            present merchant, with: CityWay::Api::V1::Entities::Promo, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end
        end
      end
    end
  end
end
