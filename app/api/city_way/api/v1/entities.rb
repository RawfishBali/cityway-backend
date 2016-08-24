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
          expose :id, documentation: {:type => "integer", :desc => "City ID"}, if: lambda { |object, options| !object.id.blank? }
          expose :name, documentation: {:type => "string", :desc => "City Name"}
          expose :latitude, documentation: {:type => "float", :desc => "City Latitude"}
          expose :longitude, documentation: {:type => "float", :desc => "City Longitude"}
          expose :distance, if: lambda { |object, options| object.respond_to?(:distance) }
          expose :home, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'home'  } do |city, options|
            if options[:simple] == 'true'
              {
                photo: city.photo.url
              }
            else
              {
                photo: city.photo.url,
                weather: {
                  temperature: 21,
                  weather_icon: 'cloudy',
                  weather_message: "It's time to eat brocolli!"
                },
                top_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(0)),
                categories: CityWay::Api::V1::Entities::Category.represent(city.categories),
                bottom_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(1))
              }
            end

          end
          expose :around, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'around' } do |city, options|
            if options[:simple] == 'true'
              {
                photo: city.around.photo.url
              }
            else
              {
                photo: city.around.photo.url,
                top_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(0)),
                main_section: [],
                bottom_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(1))
              }
            end
          end
          expose :commonplace, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'city_hall' }, as: 'city_hall' do |city, options|
            if options[:simple] == 'true'
              {
                photo: city.commonplace.photo.url
              }
            else
              {
                photo: city.commonplace.photo.url,
                top_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(0)),
                main_section: [],
                bottom_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(1))
              }
            end
          end
          expose :discover, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'discover' } do |city, options|
            if options[:simple] == 'true'
              {
                photo: city.discover.photo.url
              }
            else
              {
                photo: city.discover.photo.url,
                top_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(0)),
                main_section: [],
                bottom_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(1))
              }
            end
          end
          expose :utility, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'utility' } do |city, options|
            if options[:simple] == 'true'
              {
                photo: city.utility.photo.url
              }
            else
              {
                photo: city.utility.photo.url,
                top_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(0)),
                main_section: [],
                bottom_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(1))
              }
            end
          end
        end

        class CityStructure < Grape::Entity
          expose :nearest_city do |city, options|
            CityWay::Api::V1::Entities::City.represent city, message: options[:message], simple: options[:simple]
          end
          expose :message do |city, options|
            options[:message]
          end
          expose :actual_city , if: lambda { |instance, options| options[:actual_city] } do |cities, options|
            options[:actual_city]
          end
          expose :nearby_cities, if: lambda { |instance, options| options[:cities] && options[:list] } do |cities, options|
            CityWay::Api::V1::Entities::City.represent options[:cities], simple: options[:simple]
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

        class Advertisement < Grape::Entity
          expose :photo, documentation: {:type => "String", :desc => "Advertisement's photo"} do |advertisement, options|
            advertisement.photo.url
          end
        end


      end
    end
  end
end
