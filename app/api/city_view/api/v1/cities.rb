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
            optional :lat, type: String, desc: "User Latitude"
            optional :lng, type: String, desc: "User Longitude"
          end
          get do
            if params[:lat] && params[:lng]
              origin = Geokit::LatLng.new(params[:lat],params[:lng])
              cities = City.within(5, :units => :kms, :origin => origin).page params[:page]
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
