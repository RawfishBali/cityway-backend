module CityWay
  module Api
    module V1
      class Discovers < Grape::API
        version 'v1'
        format :json

        resources :discovers do
          before do
            authenticate!
          end

          desc "Discover city"
          params do
            requires :id , type: Integer, values: -> { Discover.ids }
            requires :section , type: String, values: -> { ['visit', 'culture', 'culinary', 'story'] }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            discover = Discover.find(params[:id])
            if params[:section] == 'visit'
              present discover, with: CityWay::Api::V1::Entities::DiscoverVistingCity, latitude: params[:latitude], longitude: params[:longitude]
            elsif params[:section] == 'culture'
              present discover, with: CityWay::Api::V1::Entities::DiscoverCulture, latitude: params[:latitude], longitude: params[:longitude]
            elsif params[:section] == 'culinary'
              present discover, with: CityWay::Api::V1::Entities::DiscoverCulinary, latitude: params[:latitude], longitude: params[:longitude]
            elsif params[:section] == 'story'
              present discover, with: CityWay::Api::V1::Entities::DiscoverCityStories, latitude: params[:latitude], longitude: params[:longitude]
            end
          end
        end
      end
    end
  end
end
