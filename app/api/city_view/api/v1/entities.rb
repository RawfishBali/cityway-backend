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

        class Category < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "Category ID"}
          expose :name, documentation: {:type => "string", :desc => "City Name"}
        end

        class Merchant < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "Merchant ID"}
          expose :name, documentation: {:type => "string", :desc => "Merchant Name"}
          expose :description, documentation: {:type => "string", :desc => "Merchant description"}
          expose :address, documentation: {:type => "string", :desc => "Merchant address"}
          expose :phone, documentation: {:type => "string", :desc => "Merchant phone"}
          expose :email, documentation: {:type => "string", :desc => "Merchant email"}
          expose :website, documentation: {:type => "string", :desc => "Merchant website"}
          expose :facebook, documentation: {:type => "string", :desc => "Merchant facebook"}
          expose :instagram, documentation: {:type => "string", :desc => "Merchant instagram"}
          expose :support_disabilities, documentation: {:type => "boolean", :desc => "Merchant support_disabilities"}
        end
      end
    end
  end
end
