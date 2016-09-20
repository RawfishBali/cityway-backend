module CityWay
  module Api
    module V1
      class Utilities < Grape::API
        version 'v1'
        format :json

        resources :utilities do
          before do
            authenticate!
          end

          desc "webcams list"
          params do
            requires :id , type: Integer, values: -> { Device.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/webcams' do
            utility = Utility.find(params[:id])
            present utility.devices_by_type("webcam"), with: CityWay::Api::V1::Entities::Device, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

          desc "wifi list"
          params do
            requires :id , type: Integer, values: -> { Device.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/wifis' do
            utility = Utility.find(params[:id])
            present utility.devices_by_type("wifi"), with: CityWay::Api::V1::Entities::Device, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end
        end
      end
    end
  end
end
