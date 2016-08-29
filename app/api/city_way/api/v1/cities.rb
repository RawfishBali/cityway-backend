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
            optional :latitude, type: String, desc: "User Latitude"
            optional :longitude, type: String, desc: "User Longitude"
          end
          get do
            if params[:latitude] && params[:longitude]
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
            else
              alpha_cities = City.all.order('name ASC').page params[:page]
              add_pagination_headers alpha_cities
              present alpha_cities, with: CityWay::Api::V1::Entities::City, simple: 'true'
            end
          end

          desc "City Detail"
          params do
            requires :id , type: Integer, values: -> { City.ids }
          end
          get '/:id' do
            city = City.find(params[:id])
            present city, with: CityWay::Api::V1::Entities::City, sections: params[:sections], simple: params[:simple]
          end

          desc "City's Merchant Per Category V2"
          params do
            requires :id , type: Integer, values: -> { City.ids }
            requires :category_id , type: Integer, values: -> { Category.ids }
            optional :subcategory_id , type: Integer, values: -> { Category.subcategories.ids }
          end

          get '/:id/merchants' do
            category = Category.find(params[:category_id])
            if params[:subcategory_id].blank?
              subcategories = category.subcategories
              merchants = Merchant.where(city_id: params[:id] , category_id: params[:category_id]).page params[:page]
            else
              merchants = Merchant.joins(:subcategories).where('merchants.city_id = ? AND categories_merchants.category_id = ?' ,params[:id], params[:subcategory_id]).page params[:page]
            end

            add_pagination_headers merchants

            present category, with: CityWay::Api::V1::Entities::CategoryWithMerchants, merchants: merchants, subcategories: subcategories
          end




          desc "City's Promos"
          params do
            requires :id , type: Integer, values: -> { City.ids }
            optional :category_id , type: Integer, values: -> { Category.ids }
            optional :subcategory_id , type: Integer, values: -> { Category.ids }
          end

          get '/:id/promos' do
            promos = Promo.where(city_id: params[:id])
            present promos, with: CityWay::Api::V1::Entities::Promo
          end
        end

      end
    end
  end
end
