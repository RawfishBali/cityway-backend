module CityWay
  module Api
    module V1
      module Entities

        class Around < Grape::Entity
          expose :photo, documentation: {:type => "String", :desc => "Around Photo"} do |aro, options|
            aro.photo.url
          end
        end

        class Commonplace < Grape::Entity
          expose :photo, documentation: {:type => "String", :desc => "Commonplace Photo"} do |common, options|
            common.photo.url
          end
        end

        class Discover < Grape::Entity
          expose :photo, documentation: {:type => "String", :desc => "Discover Photo"} do |disc, options|
            disc.photo.url
          end
        end

        class Utility < Grape::Entity
          expose :photo, documentation: {:type => "String", :desc => "Utility Photo"} do |disc, options|
            disc.photo.url
          end
        end

        class City < Grape::Entity
          expose :message, if: lambda { |object, options| options[:message] } do |object, options|
            options[:message]
          end
          expose :id, documentation: {:type => "integer", :desc => "City ID"}, if: lambda { |object, options| !object.id.blank? }
          expose :name, documentation: {:type => "string", :desc => "City Name"}
          expose :latitude, documentation: {:type => "float", :desc => "City Latitude"}
          expose :longitude, documentation: {:type => "float", :desc => "City Longitude"}
          expose :distance, if: lambda { |object, options| object.respond_to?(:distance) }
          expose :description, documentation: {:type => "string", :desc => "City description"} do |city, options|
            city.description.nil? ? "No Description" : city.description
          end
          expose :around, using: CityWay::Api::V1::Entities::Around, if: lambda { |object, options| object.around }, as: 'intorno'
          expose :commonplace, using: CityWay::Api::V1::Entities::Commonplace, if: lambda { |object, options| object.commonplace }, as: 'comune'
          expose :discover, using: CityWay::Api::V1::Entities::Discover, if: lambda { |object, options| object.discover }, as: 'scopri'
          expose :utility, using: CityWay::Api::V1::Entities::Utility, if: lambda { |object, options| object.utility }, as: 'utilita'
        end

        class CityWithMessages < Grape::Entity

          expose :nearerst_city do |city, options|
            CityWay::Api::V1::Entities::City.represent city, message: options[:message]
          end
          expose :nearby_cities, if: lambda { |instance, options| options[:cities] } do |cities, options|
            CityWay::Api::V1::Entities::City.represent options[:cities]
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
          expose :is_parent_category, documentation: {:type => "boolean", :desc => ""} do |category, options|
            category.parent_id.blank?
          end
          expose :subcategories, if: lambda { |object, options| !object.subcategories.blank? } do |category, options|
            category.subcategories.map { |subcategory|
                {
                  id: subcategory.id,
                  name: subcategory.name
                }
              }

          end
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

        class User < Grape::Entity
          expose :firstname, documentation: {:type => "String", :desc => "User firstname"}
          expose :lastname, documentation: {:type => "String", :desc => "User lastname"}
          expose :newsletter, documentation: {:type => "Boolean", :desc => "User newsletter subscription"}
        end


      end
    end
  end
end
