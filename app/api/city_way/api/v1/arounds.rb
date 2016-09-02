module CityWay
  module Api
    module V1
      class Arounds < Grape::API
        version 'v1'
        format :json

        resources :arounds do
          before do
            authenticate!
          end

          desc "Around Detail"
          params do
            requires :id , type: Integer, values: -> { Around.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            around = Around.find(params[:id])
            present around, with: CityWay::Api::V1::Entities::Around, latitude: params[:latitude], longitude: params[:longitude]
          end


          desc "Around Events"
          params do
            requires :id , type: Integer, values: -> { Around.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/events' do
            around = Around.find(params[:id])
            events = around.active_events.page params[:page]
            add_pagination_headers events
            present events, with: CityWay::Api::V1::Entities::Event, simple: 'true', latitude: params[:latitude], longitude: params[:longitude], promo_mode: 'true'
          end

        end
      end
    end
  end
end
