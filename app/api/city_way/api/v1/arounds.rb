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
            advertisements = around.city.active_advertisements
            present around, with: CityWay::Api::V1::Entities::Around, latitude: params[:latitude], longitude: params[:longitude], advertisements: advertisements, simple: 'true'
          end


          desc "Around Events"
          params do
            requires :id , type: Integer, values: -> { Around.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
            optional :day, type: String
          end
          get '/:id/events' do
            around = Around.find(params[:id])
            city_id = around.city.id

            if params[:day]
              events = Event.joins(:cities_events).joins(:event_dates).where('cities_events.city_id = ?  and event_dates.event_date >= ? and event_dates.event_date = ?',city_id, Time.now, Date.parse(params[:day])).page params[:page]

              # events = (Event.events_open_on params[:day]).page params[:page]
            else
              events = Event.joins(:cities_events).joins(:event_dates).where('cities_events.city_id = ?  and event_dates.event_date >= ?',city_id, Time.now).page params[:page]
              # events = around.active_events.page params[:page]
            end


            add_pagination_headers events
            present events, with: CityWay::Api::V1::Entities::Event, simple: 'true', latitude: params[:latitude], longitude: params[:longitude], promo_mode: 'true'
          end


          desc "Around Markets"
          params do
            requires :id , type: Integer, values: -> { Around.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
            optional :day, type: String
          end
          get '/:id/markets' do
            around = Around.find(params[:id])
            if params[:day]
              markets = Kaminari.paginate_array(Market.markets_open_on(params[:day])).page(params[:page])

            else
              markets = around.markets.page(params[:page])
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
