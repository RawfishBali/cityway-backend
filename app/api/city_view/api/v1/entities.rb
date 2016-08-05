module CityView
  module Api
    module V1
      module Entities

        class City < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "City ID"}
          expose :name, documentation: {:type => "string", :desc => "City Name"}
          expose :latitude, documentation: {:type => "float", :desc => "City Latitude"}
          expose :longitude, documentation: {:type => "float", :desc => "City Longitude"}
          expose :distance, if: lambda { |object, options| object.respond_to?(:distance) }
          expose :description, documentation: {:type => "string", :desc => "City description"} do |citi, options|
            citi.description.nil? ? "No Description" : citi.description
          end
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
