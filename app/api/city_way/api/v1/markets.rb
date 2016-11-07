module CityWay
  module Api
    module V1
      class Markets < Grape::API
        version 'v1'
        format :json

        resources :markets do
          before do
            authenticate!
          end

          desc "Market Detail"
          params do
            requires :id , type: Integer, values: -> { Market.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            market = Market.find(params[:id])
            present market, with: CityWay::Api::V1::Entities::Market, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

        end
      end
    end
  end
end
