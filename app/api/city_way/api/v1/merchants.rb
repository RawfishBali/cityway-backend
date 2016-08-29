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
          end
          get '/:id' do
            merchant = Merchant.find(params[:id])
            present merchant, with: CityWay::Api::V1::Entities::Merchant
          end
        end

      end
    end
  end
end
