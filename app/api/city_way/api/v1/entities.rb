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
          expose :id, documentation: {:type => "Integer", :desc => "Category ID"}
          expose :name, documentation: {:type => "String", :desc => "Category Name"}
          expose :photo, documentation: {:type => "String", :desc => "Category Photo"} do |category, options|
            category.photo.url
          end
          expose :icon, documentation: {:type => "String", :desc => "Category Icon"} do |category, options|
            category.icon.url
          end
        end

        class CategoryWithMerchants < Grape::Entity
          expose :merchants do |category , options|
            CityWay::Api::V1::Entities::Merchant.represent(options[:merchants])
          end
          expose :subcategories, if: lambda { |object, options| !options[:subcategories].blank? } do |category , options|
            CityWay::Api::V1::Entities::Category.represent(options[:subcategories])
          end
        end

        class CategoryWithPromos < Grape::Entity
          expose :promos do |category , options|
            CityWay::Api::V1::Entities::Promo.represent(options[:promos])
          end
          expose :subcategories do |category , options|
            CityWay::Api::V1::Entities::Category.represent(options[:subcategories])
          end
        end

        class BusinessHours < Grape::Entity
          expose :day do |business_hour , options|
            Date::ABBR_DAYNAMES[business_hour.day]
          end
          expose :morning_open_time do |business_hour , options|
            business_hour.morning_open_time.strftime("%H:%M")
          end
          expose :morning_close_time do |business_hour , options|
            business_hour.morning_close_time.strftime("%H:%M")
          end
          expose :evening_open_time do |business_hour , options|
            business_hour.evening_open_time.strftime("%H:%M")
          end
          expose :evening_close_time do |business_hour , options|
            business_hour.evening_close_time.strftime("%H:%M")
          end
          expose :is_open do |business_hour , options|
            business_hour.is_open? Time.now
          end
        end

        class Photo < Grape::Entity
          expose :picture do |photo, options|
            photo.picture.url
          end
          expose :is_primary
        end

        class Merchant < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "Merchant ID"}
          expose :name, documentation: {:type => "string", :desc => "Merchant Name"}
          expose :description,if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "string", :desc => "Merchant description"}
          expose :address, documentation: {:type => "string", :desc => "Merchant address"}
          expose :photos, documentation: {:type => "string", :desc => "Merchant photo"} do |merchant , options|
            if options[:simple] == 'false'
              CityWay::Api::V1::Entities::Photo.represent(merchant.photos) if merchant.photos.length > 0
            else
              merchant.primary_photo.picture.url if merchant.photos.length > 0
            end
          end
          expose :icon, documentation: {:type => "string", :desc => "Merchant icon"} do |merchant , options|
            merchant.icon.url
          end
          expose :latitude, documentation: {:type => "float", :desc => "Merchant Latitude"}
          expose :longitude, documentation: {:type => "float", :desc => "Merchant Longitude"}
          expose :phone,if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "string", :desc => "Merchant phone"}
          expose :email,if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "string", :desc => "Merchant email"}
          expose :website, if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "string", :desc => "Merchant website"}
          expose :facebook, if: lambda { |object, options| options[:simple] == 'false' },documentation: {:type => "string", :desc => "Merchant facebook"}
          expose :instagram, if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "string", :desc => "Merchant instagram"}
          expose :support_disabilities, documentation: {:type => "boolean", :desc => "Merchant support_disabilities"}
          expose :distance, if: lambda { |object, options| object.respond_to?(:distance) }
          expose :has_promos, documentation: {:type => "Boolean", :desc => "Merchant Has Promos Or Not"} do |merchant , options|
            merchant.promos.any?
          end
          expose :business_hours,if: lambda { |object, options| options[:simple] == 'false' && options[:promo_mode] != 'true' } do |merchant , options|
            CityWay::Api::V1::Entities::BusinessHours.represent(merchant.business_hours.order('day ASC'))
          end
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

        class Promo < Grape::Entity
          expose :id, documentation: {:type => "String", :desc => "Promo's photo"}
          expose :photo, documentation: {:type => "String", :desc => "Promo's photo"}
          expose :description,if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "Text", :desc => "Promo's description"}
          expose :terms_and_conditions,if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "Text", :desc => "Promo's terms_and_conditions"}
          expose :discount, documentation: {:type => "Float", :desc => "Promo's discount"}
          expose :original_price, documentation: {:type => "Float", :desc => "Promo's original_price"}
          expose :discount_price, documentation: {:type => "Float", :desc => "Promo's discount_price"}
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |promo , options|
            promo.merchant.distance_from([options[:latitude], options[:longitude]])
          end
          expose :merchant do |promo, options|
            if options[:simple] == 'false'
              CityWay::Api::V1::Entities::Merchant.represent promo.merchant
            else
              promo.merchant.name
            end
          end
        end
      end
    end
  end
end
