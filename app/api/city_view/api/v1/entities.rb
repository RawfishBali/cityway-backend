module CityView
  module Api
    module V1
      module Entities

        class City < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "City ID"}
          expose :name, documentation: {:type => "string", :desc => "City Name"}
          expose :lat, documentation: {:type => "float", :desc => "City Latitude"}
          expose :long, documentation: {:type => "float", :desc => "City Longitude"}
          expose :distance, documentation: {:type => "float", :desc => "City's distance from user's location"}
        end

        class AccessToken < Grape::Entity
          expose :access_token, :documentation => {:type => "string", :desc => "Access Token"} do |access_token, options|
            access_token.token
          end
        end
      end
    end
  end
end
