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

          desc  "List Of Arounds"
          params do

          end
          get do
            arounds = Around.all
            # add_pagination_headers arounds
            present arounds, with: CityWay::Api::V1::Entities::Around
          end
        end

      end
    end
  end
end
