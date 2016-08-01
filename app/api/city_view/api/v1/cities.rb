
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
            optional :sort, type: Hash do
              optional :name, type: String, values: -> { ['asc', 'desc'] }
            end
          end
          get do
            cities = City.all

            add_pagination_headers cities

            present cities, with: CityView::Api::V1::Entities::City
          end
        end

      end
    end
  end
end
