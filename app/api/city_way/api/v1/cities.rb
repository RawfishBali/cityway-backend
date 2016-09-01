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

          desc "City's Merchant Per Category Or Per Subcategory"
          params do
            requires :id , type: Integer, values: -> { City.ids }
            requires :category_id , type: Integer, values: -> { Category.ids }
            optional :subcategory_id , type: Integer, values: -> { Category.subcategories.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end

          get '/:id/merchants' do
            category = Category.find(params[:category_id])
            if params[:subcategory_id].blank?
              subcategories = category.subcategories
              merchants = Merchant.where(city_id: params[:id] , category_id: params[:category_id]).page params[:page]
            else
              merchants = Merchant.joins(:subcategories).where('merchants.city_id = ? AND categories_merchants.category_id = ?' ,params[:id], params[:subcategory_id]).page params[:page]
            end
            merchants = merchants.near([params[:latitude],params[:longitude]], 100, units: :km) if params[:latitude] && params[:longitude]
            add_pagination_headers merchants

            present category, with: CityWay::Api::V1::Entities::CategoryWithMerchants, merchants: merchants, subcategories: subcategories, simple: 'true'
          end


          desc "City's Promos"
          params do
            requires :id , type: Integer, values: -> { City.ids }
            optional :category_id , type: Integer, values: -> { Category.ids }
            optional :subcategory_id , type: Integer, values: -> { Category.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end

          get '/:id/promos' do
            if params[:category_id]
              category = Category.find(params[:category_id])
              subcategories = category.subcategories
              if params[:subcategory_id].blank?
                promos = Promo.joins(:merchant).where('merchants.city_id = ? and merchants.category_id = ?', params[:id], params[:category_id]).page params[:page]
              else
                merchants = Merchant.joins(:subcategories).where('merchants.city_id = ? AND categories_merchants.category_id = ?' ,params[:id], params[:subcategory_id])
                temp_promos = []
                merchants.each do |m|
                  m.promos.each do |promo|
                    temp_promos << promo
                  end
                end
                promos = Kaminari.paginate_array(temp_promos).page(params[:page])
              end
            else
              promos = Promo.where(city_id: params[:id]).page params[:page]
            end

            add_pagination_headers promos
            present promos, with: CityWay::Api::V1::Entities::Promo, latitude: params[:latitude], longitude: params[:longitude]
          end
        end

      end
    end
  end
end
