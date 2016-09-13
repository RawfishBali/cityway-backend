module CityWay
  module Api
    module V1
      module Entities

        class Event < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Event ID"}
          expose :title, documentation: {:type => "String", :desc => "Event Title"}
          expose :photo, documentation: {:type => "String", :desc => "Event Photo"} do |event, options|
            event.photo.url
          end
          expose :address, documentation: {:type => "String", :desc => "Event Address"}
          expose :latitude, documentation: {:type => "Float", :desc => "Event Latitude"}
          expose :longitude, documentation: {:type => "Float", :desc => "Event Longitude"}
          expose :website, if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "String", :desc => "Event Website"}
          expose :email, if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "String", :desc => "Event Email"}
          expose :facebook, if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "String", :desc => "Event Facebook"} do |event, options|
            matches = event.facebook.match(/(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:groups\/)?(?:pages\/)?(?:[\w\-]*\/)*?(\/)?([\w\-\.]*)/) if event.facebook
            if matches
              matches[2]
            else
              event.facebook
            end
          end
          expose :instagram,  if: lambda { |object, options| options[:simple] == 'false' },documentation: {:type => "String", :desc => "Event Instagram"}
          expose :support_disabilities, documentation: {:type => "Boolean", :desc => "Event Disabilities Support"}
          expose :event_start, documentation: {:type => "DateTime", :desc => "Event Start"} do |event, options|
            event.event_start.strftime("%m/%d/%Y")
          end
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |event , options|
            event.distance_from([options[:latitude], options[:longitude]])
          end
          expose :description, documentation: {:type => "Text", :desc => "Event Description"}
        end


        class Market < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Market ID"}
          expose :address, documentation: {:type => "String", :desc => "Market Address"}
          expose :latitude, documentation: {:type => "Float", :desc => "Market latitude"}
          expose :longitude, documentation: {:type => "Float", :desc => "Market longitude"}
          expose :open_time, documentation: {:type => "String", :desc => "Market Open Time"} do |market , options|
            market.open_time.strftime("%H:%M")
          end
          expose :close_time, documentation: {:type => "String", :desc => "Market Close Time"} do |market , options|
            market.close_time.strftime("%H:%M")
          end
          expose :description, documentation: {:type => "Text", :desc => "Market Description"}
          expose :day_opens, documentation: {:type => "Array", :desc => "Market Open Days"} do |market , options|
            market.day_opens.collect { |x| Date::DAYNAMES[x] }.join(" , ")
          end
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |market , options|
            market.distance_from([options[:latitude], options[:longitude]])
          end
          expose :photos, documentation: {:type => "string", :desc => "Market photo"} do |market , options|
            if options[:simple] == 'false'
              CityWay::Api::V1::Entities::Photo.represent(market.photos) if market.photos.length > 0
            else
              CityWay::Api::V1::Entities::Photo.represent(market.primary_photo) if market.photos.length > 0
            end
          end
        end

        class Park < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Park ID"}
          expose :address, documentation: {:type => "String", :desc => "Park Address"}
          expose :latitude, documentation: {:type => "Float", :desc => "Park latitude"}
          expose :longitude, documentation: {:type => "Float", :desc => "Park longitude"}
          expose :description, if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "Text", :desc => "Park Description"}
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |market , options|
            market.distance_from([options[:latitude], options[:longitude]])
          end
          expose :photos, documentation: {:type => "string", :desc => "Park photo"} do |market , options|
            if options[:simple] == 'false'
              CityWay::Api::V1::Entities::Photo.represent(market.photos) if market.photos.length > 0
            else
              CityWay::Api::V1::Entities::Photo.represent(market.primary_photo) if market.photos.length > 0
            end
          end
        end


        class Around < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Around ID"}
          expose :photo, documentation: {:type => "String", :desc => "Around Photo"} do |around, options|
            around.photo.url
          end
          expose :top_advertisements do |around, options|
            CityWay::Api::V1::Entities::Advertisement.represent(around.city.active_advertisements(0))
          end
          expose :events, if: lambda { |object, options| options[:simple] == 'false' } do |around, options|
            CityWay::Api::V1::Entities::Event.represent(around.active_events)
          end
          expose :bottom_advertisements do |around, options|
            CityWay::Api::V1::Entities::Advertisement.represent(around.city.active_advertisements(1))
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
                  temperature: options[:forecast].currently[:temperature],
                  weather_icon: options[:forecast].currently[:icon],
                  weather_message: options[:forecast].daily[:summary]
                },
                top_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(0)),
                categories: CityWay::Api::V1::Entities::Category.represent(city.categories),
                bottom_advertisements: CityWay::Api::V1::Entities::Advertisement.represent(city.active_advertisements(1))
              }
            end

          end
          expose :around, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'around' } do |city, options|
            CityWay::Api::V1::Entities::Around.represent(city.around)
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
          expose :photo,if: lambda { |object, options| !object.parent_id }, documentation: {:type => "String", :desc => "Category Photo"} do |category, options|
            category.photo.url
          end
          expose :icon,if: lambda { |object, options| !object.parent_id }, documentation: {:type => "String", :desc => "Category Icon"} do |category, options|
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
            I18n.t(:"date.day_names")[business_hour.day]
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
          expose :picture, as: 'photo' do |photo, options|
            photo.picture.url
          end
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
              CityWay::Api::V1::Entities::Photo.represent(merchant.primary_photo) if merchant.photos.length > 0
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
          expose :facebook, if: lambda { |object, options| options[:simple] == 'false' },
            documentation: {:type => "string", :desc => "Merchant facebook"} do |merchant, options|
            matches = merchant.facebook.match(/(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:groups\/)?(?:pages\/)?(?:[\w\-]*\/)*?(\/)?([\w\-\.]*)/)
            if matches
              matches[2]
            else
              merchant.facebook
            end

          end
          expose :instagram, if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "string", :desc => "Merchant instagram"}
          expose :support_disabilities, documentation: {:type => "boolean", :desc => "Merchant support_disabilities"}
          expose :distance, if: lambda { |object, options| object.respond_to?(:distance) || options[:latitude] && options[:longitude] } do |merchant , options|
            if merchant.respond_to?(:distance)
              merchant.distance
            elsif options[:latitude] && options[:longitude]
              merchant.distance_from([options[:latitude], options[:longitude]])
            end
          end
          expose :has_promos, documentation: {:type => "Boolean", :desc => "Merchant Has Promos Or Not"} do |merchant , options|
            merchant.promos.any?
          end
          expose :business_hours,if: lambda { |object, options| options[:simple] == 'false' } do |merchant , options|
            CityWay::Api::V1::Entities::BusinessHours.represent(merchant.business_hours.order('day ASC'))
          end
          expose :is_open do |merchant , options|
            merchant.is_open_now?
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
          expose :title,as: 'name',  documentation: {:type => "String", :desc => "Promo's Name"}
          expose :photo, documentation: {:type => "String", :desc => "Promo's photo"} do |promo, options|
            promo.photo.url
          end
          expose :description,if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "Text", :desc => "Promo's description"}
          expose :terms_and_conditions,if: lambda { |object, options| options[:simple] == 'false' }, documentation: {:type => "Text", :desc => "Promo's terms_and_conditions"}
          expose :discount, documentation: {:type => "Float", :desc => "Promo's discount"}
          expose :original_price, documentation: {:type => "Float", :desc => "Promo's original_price"}
          expose :discount_price, documentation: {:type => "Float", :desc => "Promo's discount_price"}
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |promo , options|
            promo.merchant.distance_from([options[:latitude], options[:longitude]])
          end
          expose :merchant do |promo, options|
              CityWay::Api::V1::Entities::Merchant.represent promo.merchant
          end
        end
      end
    end
  end
end
