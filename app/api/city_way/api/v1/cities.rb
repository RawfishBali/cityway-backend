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
            optional :list , type: Boolean
            requires :latitude, type: String, desc: "User Latitude"
            requires :longitude, type: String, desc: "User Longitude"
          end
          get do
            user_city = City.new(latitude: params[:latitude], longitude: params[:longitude])
            city_name = user_city.reverse_geocode

            city = City.find_by(name: city_name)

            if city
              message = "Ti trovi a..."
            else
              city = City.near([params[:latitude],params[:longitude]], 20000, units: :km).first
              message = "Cityway sarà presto presente anche a"
            end

            alpha_cities = City.where.not(name: city.name).near([params[:latitude],params[:longitude]], 20000, units: :km, order: 'name ASC').page params[:page]

            add_pagination_headers alpha_cities
            present city, with: CityWay::Api::V1::Entities::CityStructure, cities: alpha_cities, message: message, list: params[:list], actual_city: city_name, simple: 'true'
          end

          desc "City Detail"
          params do
            requires :id , type: Integer, values: -> { City.ids }
          end
          get '/:id' do
            city = City.find(params[:id])
            present city, with: CityWay::Api::V1::Entities::City, sections: params[:sections], simple: params[:simple]
          end

          desc "City's Merchant Per Category"
          params do
            requires :id , type: Integer, values: -> { City.ids }
            requires :category_id , type: Integer, values: -> { Category.ids }
          end
          get '/:id/category/:category_id' do
            merchants = Merchant.where(city_id: params[:id] , category_id: params[:category_id])
            subcategories = Category.find(params[:category_id]).subcategories
            present merchants, with: CityWay::Api::V1::Entities::CategoryMerchants, subcategories: subcategories
          end
        end

      end
    end
  end
end
