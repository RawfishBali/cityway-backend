module CityView
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
            optional :latitude, type: String, desc: "User Latitude"
            optional :longitude, type: String, desc: "User Longitude"
          end
          get do
            if params[:latitude] && params[:longitude]
              cities = City.near([params[:latitude],params[:longitude]], 20, units: :km, order: 'name ASC').page params[:page]
            else
              cities = City.all.page params[:page]
            end

            add_pagination_headers cities
            present cities, with: CityView::Api::V1::Entities::City
          end
        end

      end
    end
  end
end
