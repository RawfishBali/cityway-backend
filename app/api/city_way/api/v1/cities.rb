module CityWay
  module Api
    module V1
      class Cities < Grape::API
        version 'v1'
        format :json

        resources :cities do
          before do
            authenticate!
          end

          desc "List Cities"
          params do
            optional :page , type: Integer
            optional :sort, type: Hash do
              optional :name, type: String, values: -> { ['asc', 'desc'] }
            end
            requires :latitude, type: String, desc: "User Latitude"
            requires :longitude, type: String, desc: "User Longitude"
          end
          get do
            user_city = City.new(latitude: params[:latitude], longitude: params[:longitude])
            city_name = user_city.reverse_geocode

            alpha_cities = City.where.not(name: city_name).near([params[:latitude],params[:longitude]], 20000, units: :km, order: 'name ASC').page params[:page]

            city = City.find_by(name: city_name)

            if city
              message = "You're in"
            else
              city = City.near([params[:latitude],params[:longitude]], 20000, units: :km).first
              message = "You're not in the city list. The nearest city is"
            end

            add_pagination_headers alpha_cities
            present city, with: CityWay::Api::V1::Entities::CityWithMessages, cities: alpha_cities, message: message
          end

          desc "City Detail"
          params do
            requires :id , type: Integer, values: -> { City.ids }

          end
          get '/:id' do
            city = City.find(params[:id])
            present city, with: CityWay::Api::V1::Entities::City
          end
        end

      end
    end
  end
end
