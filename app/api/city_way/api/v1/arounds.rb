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


          desc "Around Markets"
          params do
            requires :id , type: Integer, values: -> { Around.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
            optional :day_id, type: Integer
          end
          get '/:id/markets' do
            around = Around.find(params[:id])
            if params[:day_id]
              markets = around.markets.where("? = ANY (day_opens)", params[:day_id]).page params[:page]
            else
              markets = around.markets.page params[:page]
            end

            add_pagination_headers markets
            present markets, with: CityWay::Api::V1::Entities::Market, simple: 'true', latitude: params[:latitude], longitude: params[:longitude]
          end


          desc "Around Parks"
          params do
            requires :id , type: Integer, values: -> { Around.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/parks' do
            parks = Around.find(params[:id]).parks.page params[:page]
            add_pagination_headers parks
            present parks, with: CityWay::Api::V1::Entities::Park, simple: 'true', latitude: params[:latitude], longitude: params[:longitude]
          end
        end
      end
    end
  end
end
