module CityWay
  module Api
    module V1
      class CityHalls < Grape::API
        version 'v1'
        format :json

        resources :city_halls do
          before do
            authenticate!
          end

          desc "CityHall Detail"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            commonplace = Commonplace.find(params[:id])
            present commonplace, with: CityWay::Api::V1::Entities::Commonplace, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

        end
      end
    end
  end
end
