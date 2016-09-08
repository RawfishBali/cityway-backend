module CityWay
  module Api
    module V1
      class Merchants < Grape::API
        version 'v1'
        format :json

        resources :merchants do
          before do
            authenticate!
          end

          desc "Merchant Detail"
          params do
            requires :id , type: Integer, values: -> { Merchant.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            merchant = Merchant.find(params[:id])
            present merchant, with: CityWay::Api::V1::Entities::Merchant, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

          desc "Merchant Detail"
          params do
            requires :id , type: Integer, values: -> { Merchant.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/promos' do
            merchant = Merchant.find(params[:id])
            promos = merchant.promos.page params[:page]
            add_pagination_headers promos
            present promos, with: CityWay::Api::V1::Entities::Promo
          end
        end

      end
    end
  end
end
