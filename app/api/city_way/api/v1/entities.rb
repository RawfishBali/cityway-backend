module CityWay
  module Api
    module V1
      module Entities

        class Place < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Place ID"}
          expose :name, documentation: {:type => "String", :desc => "Place Name"}
          expose :description, documentation: {:type => "String", :desc => "Place description"}
          expose :type ,documentation: {:type => "String", :desc => "Place Type"}, if: lambda { |object, options| object.place_type} do |place, options|
            object.place_type
          end
          expose :address, documentation: {:type => "String", :desc => "Place address"}
          expose :latitude, documentation: {:type => "Float", :desc => "Place latitude"}
          expose :longitude, documentation: {:type => "Float", :desc => "Place longitude"}
          expose :email, if: lambda { |object, options| options[:simple] == 'false' && object.email }, documentation: {:type => "String", :desc => "Place email"}
          expose :website, if: lambda { |object, options| options[:simple] == 'false' && object.website }, documentation: {:type => "String", :desc => "Place website"}
          expose :facebook, if: lambda { |object, options| options[:simple] == 'false' && object.facebook }, documentation: {:type => "String", :desc => "Place facebook"} do |place, options|
            matches = place.facebook.match(/(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:groups\/)?(?:pages\/)?(?:[\w\-]*\/)*?(\/)?([\w\-\.]*)/)
            if matches
              matches[2]
            else
              place.facebook
            end
          end
          expose :instagram,if: lambda { |object, options| options[:simple] == 'false' && object.instagram }, documentation: {:type => "String", :desc => "Place instagram"} do |place, options|
            unless place.instagram[/\Ahttp:\/\//] || place.instagram[/\Ahttps:\/\//]
              "https://#{place.instagram}"
            else
              place.instagram
            end
          end
          expose :twitter, if: lambda { |object, options| options[:simple] == 'false' && object.twitter }, documentation: {:type => "String", :desc => "Place twitter"} do |place, options|
            unless place.twitter[/\Ahttp:\/\//] || place.twitter[/\Ahttps:\/\//]
              "https://#{place.twitter}"
            else
              place.twitter
            end
          end
          expose :google_plus,if: lambda { |object, options| options[:simple] == 'false' && object.google_plus }, documentation: {:type => "String", :desc => "Place google_plus"} do |place, options|
            unless place.google_plus[/\Ahttp:\/\//] || place.google_plus[/\Ahttps:\/\//]
              "https://#{place.google_plus}"
            else
              place.google_plus
            end
          end
          expose :photos, documentation: {:type => "string", :desc => "Place photo"} do |place , options|
            if options[:simple] == 'false'
              CityWay::Api::V1::Entities::Photo.represent(place.photos) if place.photos.length > 0
            else
              CityWay::Api::V1::Entities::Photo.represent(place.primary_photo) if place.photos.length > 0
            end
          end
          expose :business_hours,if: lambda { |object, options| options[:simple] == 'false' && (object.place_type == 'monument' || object.place_type == 'library' || object.place_type == 'theater') } do |place , options|
            CityWay::Api::V1::Entities::BusinessHours.represent(place.all_business_hours)
          end
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |object , options|
            object.distance_from([options[:latitude], options[:longitude]])
          end
          expose :duration, if: lambda { |object, options| options[:latitude] && options[:longitude] && options[:with_distance] == 'true' } do |object , options|
            response = object.get_duration_from(options[:latitude], options[:longitude])
            if response["rows"][0]["elements"][0]["status"] == "OK"
              response["rows"][0]["elements"][0]["duration"]["text"]
              # if we need customs value text later
              # response["rows"][0]["elements"][0]["duration"]["value"]
            else
              response["rows"][0]["elements"][0]["status"]
            end
          end
        end

        class Step < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Step ID"}
          expose :position, documentation: {:type => "Integer", :desc => "Step position"}
          expose :name, documentation: {:type => "String", :desc => "Step name"}
          expose :description, documentation: {:type => "String", :desc => "Step address"}
          expose :address, documentation: {:type => "String", :desc => "Step address"}
          expose :latitude, documentation: {:type => "Float", :desc => "Step latitude"}
          expose :longitude, documentation: {:type => "Float", :desc => "Step longitude"}
        end

        class Itinerary < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Itinerary ID"}
          expose :type , documentation: {:type => "String", :desc => "Itinerary Type"} do |itinerary, options|
            itinerary.class.name.downcase
          end
          expose :name, documentation: {:type => "String", :desc => "Itinerary Name"}
          expose :visiting_time, documentation: {:type => "String", :desc => "Itinerary Visiting Time"}
          expose :description, documentation: {:type => "Text", :desc => "Itinerary description"}
          expose :photos, documentation: {:type => "string", :desc => "Park photo"} do |itinerary , options|
            if options[:simple] == 'false'
              CityWay::Api::V1::Entities::Photo.represent(itinerary.photos) if itinerary.photos.length > 0
            else
              CityWay::Api::V1::Entities::Photo.represent(itinerary.primary_photo) if itinerary.photos.length > 0
            end
          end
          expose :steps,if: lambda { |object, options| options[:simple] == 'false' && object.steps } do |itinerary , options|
            CityWay::Api::V1::Entities::Step.represent(itinerary.steps.order('position ASC'))
          end
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |object , options|
            object.steps.order('position ASC').first.distance_from([options[:latitude], options[:longitude]])
          end
          expose :duration, if: lambda { |object, options| options[:latitude] && options[:longitude] && options[:with_distance] == 'true' } do |object , options|
            response = object.get_duration_from(options[:latitude], options[:longitude])
            if response["rows"][0]["elements"][0]["status"] == "OK"
              response["rows"][0]["elements"][0]["duration"]["text"]
              # if we need customs value text later
              # response["rows"][0]["elements"][0]["duration"]["value"]
            else
              response["rows"][0]["elements"][0]["status"]
            end
          end
        end

        class Culinary < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Culinary ID"}
          expose :type , documentation: {:type => "Integer", :desc => "Culinary type"} do |object, options|
            object.culinary_type
          end
          expose :name, documentation: {:type => "String", :desc => "Culinary Name"}
          expose :description, documentation: {:type => "Text", :desc => "Culinary description"}
          expose :photos, documentation: {:type => "string", :desc => "Culinary photo"} do |culinary , options|
            if options[:simple] == 'false'
              CityWay::Api::V1::Entities::Photo.represent(culinary.photos) if culinary.photos.length > 0
            else
              CityWay::Api::V1::Entities::Photo.represent(culinary.primary_photo) if culinary.photos.length > 0
            end
          end
        end

        class EventDate < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "EventDate ID"}
          expose :event_date, documentation: {:type => "Date", :desc => "EventDate Date"}
          expose :open_time, documentation: {:type => "Time", :desc => "EventDate Open Time"} do |object, options|
            object.open_time.strftime("%H:%M")
          end
          expose :close_time, documentation: {:type => "Close", :desc => "EventDate Close Time"}do |object, options|
            object.close_time.strftime("%H:%M")
          end
        end

        class Event < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Event ID"}
          expose :title, as: 'name',  documentation: {:type => "String", :desc => "Event Title"}
          expose :photos, documentation: {:type => "String", :desc => "Event Photo"} do |event, options|
            CityWay::Api::V1::Entities::Photo.represent([event.photo]) if event.photo
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
          expose :instagram,  if: lambda { |object, options| options[:simple] == 'false' && object.instagram },documentation: {:type => "String", :desc => "Event Instagram"} do |event, options|
            unless event.instagram[/\Ahttp:\/\//] || event.instagram[/\Ahttps:\/\//]
              "https://#{event.instagram}"
            else
              event.instagram
            end
          end
          expose :support_disabilities, documentation: {:type => "Boolean", :desc => "Event Disabilities Support"}
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |event , options|
            event.distance_from([options[:latitude], options[:longitude]])
          end
          expose :description, documentation: {:type => "Text", :desc => "Event Description"}, if: lambda { |object, options| options[:simple] == 'false' }
          expose :is_open do |event, options|
            event.is_open_today
          end
          expose :event_dates do |event, options|
            CityWay::Api::V1::Entities::EventDate.represent event.event_dates.order('event_date ASC')
          end
          expose :type do |event, options|
            event.class.name.downcase
          end
        end

        class News < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "News' ID"}
          expose :title, documentation: {:type => "String", :desc => "News' Title"}
          expose :url, documentation: {:type => "String", :desc => "News' URL"}
          expose :description, documentation: {:type => "Text", :desc => "News' Description"}
          expose :published_at, documentation: {:type => "Text", :desc => "News' Published Date"} do |news , options|
            news.published_at.strftime("%B %d %Y %H:%M")
          end
          expose :photo, documentation: {:type => "Text", :desc => "News' Photo"}  do |news, options|
            news.photo.url
          end
        end

        class Market < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Market ID"}
          expose :name, documentation: {:type => "String", :desc => "Market Name"}
          expose :address, documentation: {:type => "String", :desc => "Market Address"}
          expose :latitude, documentation: {:type => "Float", :desc => "Market latitude"}
          expose :longitude, documentation: {:type => "Float", :desc => "Market longitude"}
          expose :description, documentation: {:type => "Text", :desc => "Market Description"}, if: lambda { |object, options| options[:simple] == 'false' }
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
          expose :type do |market, options|
            market.class.name.downcase
          end
          expose :business_hours do |object, options|
            CityWay::Api::V1::Entities::BusinessHours.represent(object.all_business_hours)
          end
        end

        class Park < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Park ID"}
          expose :name, documentation: {:type => "String", :desc => "Park Name"}
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
          expose :business_hours,if: lambda { |object, options| options[:simple] == 'false' } do |event , options|
            CityWay::Api::V1::Entities::BusinessHours.represent(event.all_business_hours)
          end
          expose :type do |park, options|
            park.class.name.downcase
          end
        end

        class PublicOffice < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Public Office ID"}
          expose :name, documentation: {:type => "Integer", :desc => "Public Office Name"}
          expose :photo, documentation: {:type => "Integer", :desc => "Public Office Photo"}  do |public_office , options|
            public_office.photo.url
          end
          expose :description, documentation: {:type => "Integer", :desc => "Public Office Description"}
          expose :email, documentation: {:type => "Integer", :desc => "Public Office Email"}
          expose :address, documentation: {:type => "Integer", :desc => "Public Office Address"}
          expose :phone, documentation: {:type => "Integer", :desc => "Public Office Phone"}
          expose :fax, documentation: {:type => "Integer", :desc => "Public Office fax"}
          expose :days_open, documentation: {:type => "Integer", :desc => "Public Office days_open"} do |public_office , options|
            public_office.days_open.collect { |x| Date::DAYNAMES[x] }.join(" , ") if public_office.days_open
          end
          expose :open_time, documentation: {:type => "Integer", :desc => "Public Office Open Time"} do |public_office , options|
            public_office.open_time.strftime("%H:%M") if public_office.open_time
          end
          expose :close_time, documentation: {:type => "Integer", :desc => "Public Office Close Time"} do |public_office , options|
            public_office.close_time.strftime("%H:%M") if public_office.close_time
          end
        end

        class Around < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Around ID"}
          expose :photo, documentation: {:type => "String", :desc => "Around Photo"} do |around, options|
            around.photo.url
          end
          expose :top_advertisements do |around, options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["top"])
          end
          expose :events do |around, options|
            CityWay::Api::V1::Entities::Event.represent(around.active_events)
          end
          expose :parks do |around, options|
            CityWay::Api::V1::Entities::Park.represent(around.parks)
          end
          expose :markets do |around, options|
            CityWay::Api::V1::Entities::Market.represent(around.markets)
          end
          expose :bottom_advertisements do |around, options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["bottom"])
          end
        end

        class Profile < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Profile ID"}
          expose :name, documentation: {:type => "String", :desc => "Profile Name"}
          expose :role, documentation: {:type => "String", :desc => "Profile Role"}
          expose :email, documentation: {:type => "String", :desc => "Profile Emails"}
          expose :website, documentation: {:type => "String", :desc => "Profile Website"}
          expose :city_hall_name, documentation: {:type => "String", :desc => "Profile City Hall Name"}
          expose :description, documentation: {:type => "Text", :desc => "Profile Description"}
          expose :fax, documentation: {:type => "String", :desc => "Profile Fax"}
          expose :phone, documentation: {:type => "String", :desc => "Profile Phone"}
          expose :days_open, documentation: {:type => "String", :desc => "Profile Days Open"} do |profile, options|
            profile.days_open.collect { |x| Date::DAYNAMES[x] }.join(" , ") if profile.days_open
          end
          expose :appointment_start, documentation: {:type => "String", :desc => "Profile appointment start"}  do |profile , options|
            profile.appointment_start.strftime("%H:%M")
          end
          expose :appointment_end, documentation: {:type => "String", :desc => "Profile appointment end"} do |profile , options|
            profile.appointment_end.strftime("%H:%M")
          end
          expose :photo, documentation: {:type => "String", :desc => "Profile photo"}  do |profile, options|
            profile.photo.url
          end
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |object , options|
            object.distance_from([options[:latitude], options[:longitude]])
          end
        end

        class PoliticParty < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Politic Party ID"}
          expose :name, documentation: {:type => "String", :desc => "Politic Party Name"}
          expose :members do |politic_party, options|
            CityWay::Api::V1::Entities::Profile.represent politic_party.profiles ,latitude: options[:latitude], longitude: options[:longitude]
          end
        end

        class Administration < Grape::Entity
          expose :major do |commonplace, options|
            CityWay::Api::V1::Entities::Profile.represent commonplace.major,latitude: options[:latitude], longitude: options[:longitude]
          end
          expose :city_council do |commonplace, options|
            CityWay::Api::V1::Entities::Profile.represent commonplace.city_councils,latitude: options[:latitude], longitude: options[:longitude]
          end
          expose :council do |commonplace, options|
            CityWay::Api::V1::Entities::PoliticParty.represent commonplace.politic_groups,latitude: options[:latitude], longitude: options[:longitude]
          end
        end

        class Security < Grape::Entity
          expose :id, documentation: {:type => "String", :desc => "Security ID"}
          expose :name, documentation: {:type => "String", :desc => "Security name"}
          expose :url, if: lambda { |object, options| object.url }, documentation: {:type => "String", :desc => "Security url"} do |security, options|
            unless security.url[/\Ahttp:\/\//] || security.url[/\Ahttps:\/\//]
              "https://#{security.url}"
            else
              security.url
            end
          end
        end

        class Commonplace < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Comune ID"}
          expose :photo, documentation: {:type => "String", :desc => "Comune Photo"} do |common, options|
            common.photo.url
          end
          expose :icon, documentation: {:type => "String", :desc => "Comune Icon"} do |common, options|
            common.icon.url
          end
          expose :top_advertisements, if: lambda { |object, options| options[:simple] == 'false' }  do |around, options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["top"])
          end
          expose :facebook, if: lambda { |object, options| options[:simple] == 'false' && object.facebook }, documentation: {:type => "string", :desc => "Comune Facebook"} do |around, options|
            matches = around.facebook.match(/(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:groups\/)?(?:pages\/)?(?:[\w\-]*\/)*?(\/)?([\w\-\.]*)/)
            if matches
              matches[2]
            else
              around.facebook
            end
          end
          expose :twitter, if: lambda { |object, options| options[:simple] == 'false' && object.twitter }, documentation: {:type => "string", :desc => "Comune Twitter"} do |common, options|
            unless common.instagram[/\Ahttp:\/\//] || common.instagram[/\Ahttps:\/\//]
              "https://#{common.twitter}"
            else
              common.twitter
            end
          end
          expose :instagram, if: lambda { |object, options| options[:simple] == 'false' && object.instagram }, documentation: {:type => "string", :desc => "Comune Instagram"} do |common, options|
            unless common.instagram[/\Ahttp:\/\//] || common.instagram[/\Ahttps:\/\//]
              "https://#{common.instagram}"
            else
              common.instagram
            end
          end
          expose :google_plus, if: lambda { |object, options| options[:simple] == 'false' && object.google_plus }, documentation: {:type => "string", :desc => "Comune G+"} do |common, options|
            unless common.google_plus[/\Ahttp:\/\//] || common.google_plus[/\Ahttps:\/\//]
              "https://#{common.google_plus}"
            else
              common.google_plus
            end
          end
          expose :history, documentation: {:type => "string", :desc => "Comune History"}
        end

        class Discover < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Discover ID"}
          expose :top_advertisements, if: lambda { |object, options| options[:simple] == 'false' }  do |discover, options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["top"])
          end
          expose :photo, documentation: {:type => "String", :desc => "Discover Photo"} do |discover, options|
            discover.photo.url
          end
          expose :bottom_advertisements, if: lambda { |object, options| options[:simple] == 'false' }  do |discover, options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["bottom"])
          end
        end

        class DiscoverComplete < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Discover ID"}
          expose :visit do |discover, options|
            CityWay::Api::V1::Entities::DiscoverVistingCity.represent discover, options
          end
          expose :culture do |discover, options|
            CityWay::Api::V1::Entities::DiscoverCulture.represent discover, options
          end
          expose :culinary do |discover, options|
            CityWay::Api::V1::Entities::DiscoverCulinary.represent discover, options
          end
          expose :story do |discover, options|
            CityWay::Api::V1::Entities::DiscoverCityStories.represent discover, options
          end
        end

        class DiscoverVistingCity < Grape::Entity
          expose :monuments do |discover, options|
            CityWay::Api::V1::Entities::Place.represent discover.place_by_type("monument"), options
          end
          expose :itineraries do |discover, options|
            CityWay::Api::V1::Entities::Itinerary.represent discover.itineraries, options
          end
        end

        class DiscoverCulture < Grape::Entity
          expose :libraries do |discover, options|
            CityWay::Api::V1::Entities::Place.represent discover.place_by_type("library"), options
          end
          expose :theaters do |discover, options|
            CityWay::Api::V1::Entities::Place.represent discover.place_by_type("theater"), options
          end
          expose :museums do |discover, options|
            CityWay::Api::V1::Entities::Place.represent discover.place_by_type("museum"), options
          end
          expose :cinemas do |discover, options|
            CityWay::Api::V1::Entities::Place.represent discover.place_by_type("cinema"), options
          end
        end

        class DiscoverCulinary < Grape::Entity
          expose :gastronomies do |discover, options|
            CityWay::Api::V1::Entities::Culinary.represent discover.culinary_by_type("gastronomy"), options
          end
          expose :traditional_culinaries do |discover, options|
            CityWay::Api::V1::Entities::Culinary.represent discover.culinary_by_type("traditional"), options
          end
        end

        class Story < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "Story ID"}
          expose :top_text, documentation: {:type => "text", :desc => "Story Top Text"}
          expose :bottom_text, documentation: {:type => "text", :desc => "Story Bottom Text"}
          expose :external_link, documentation: {:type => "string", :desc => "Story External Link"}
          expose :photos, documentation: {:type => "String", :desc => "Story Photos"} do |story, options|
            CityWay::Api::V1::Entities::Photo.represent(story.photos.order('position ASC'))
          end
        end

        class DiscoverCityStories < Grape::Entity
          expose :story do |discover, options|
            CityWay::Api::V1::Entities::Story.represent discover.story
          end
        end

        class Device < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Device ID"}
          expose :type, documentation: {:type => "String", :desc => "Device Type"} do |object, options|
            object.device_type
          end
          expose :name, documentation: {:type => "String", :desc => "Device Name"}
          expose :latitude, documentation: {:type => "Float", :desc => "Device latitude"}
          expose :longitude, documentation: {:type => "Float", :desc => "Device longitude"}
          expose :external_url, documentation: {:type => "Float", :desc => "Device External Url"}
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |object , options|
            object.distance_from([options[:latitude], options[:longitude]])
          end
        end

        class Taxi < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Taxi ID"}
          expose :contact_name , documentation: {:type => "String", :desc => "Taxi Contact Name"}
          expose :phone_number, documentation: {:type => "String", :desc => "Taxi Phone Number"}
          expose :address, documentation: {:type => "String", :desc => "Taxi Phone Address"}
          expose :latitude, documentation: {:type => "String", :desc => "Taxi Phone Latitude"}
          expose :longitude, documentation: {:type => "String", :desc => "Taxi Phone Longitude"}
          expose :website, documentation: {:type => "String", :desc => "Taxi Website"}
        end

        class UtilityNumber < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Utility Number ID"}
          expose :name, documentation: {:type => "String", :desc => "Utility Number Name"}
          expose :local_number, documentation: {:type => "String", :desc => "Utility Number Local Number"}
          expose :national_number, documentation: {:type => "String", :desc => "Utility Number National Number"}
          expose :address, documentation: {:type => "String", :desc => "Utility Number Address"}
        end

        class UtilityPlace < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Utility Place ID"}
          expose :name, documentation: {:type => "String", :desc => "Utility Place Name"}
          expose :denomination, documentation: {:type => "String", :desc => "Utility Place denomination"},if: lambda { |object, options| options[:simple] == 'false' && object.denomination }
          expose :address, documentation: {:type => "String", :desc => "Utility Place Address"}
          expose :photos, documentation: {:type => "string", :desc => "Merchant photo"} do |object , options|
            if options[:simple] == 'false'
              CityWay::Api::V1::Entities::Photo.represent(object.photos) if object.photos.length > 0
            else
              CityWay::Api::V1::Entities::Photo.represent(object.primary_photo) if object.photos.length > 0
            end
          end
          expose :phone, documentation: {:type => "String", :desc => "Utility Place Phone"},if: lambda { |object, options| options[:simple] == 'false' }
          expose :business_hours,if: lambda { |object, options| options[:simple] == 'false' && object.business_hours.length > 0 } do |object , options|
            CityWay::Api::V1::Entities::BusinessHours.represent(object.all_business_hours)
          end
          expose :latitude, documentation: {:type => "float", :desc => "Utility Place Latitude"}
          expose :longitude, documentation: {:type => "float", :desc => "Utility Place Longitude"}
          expose :type, documentation: {:type => "float", :desc => "Utility Place place_type"} do |object, options|
            object.place_type
          end
          expose :distance, if: lambda { |object, options| options[:latitude] && options[:longitude] } do |object , options|
            object.distance_from([options[:latitude], options[:longitude]])
          end
        end

        class PublicTransport < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Transport ID"}
          expose :type, documentation: {:type => "Integer", :desc => "Transport Type"} do |object, options|
            object.transport_type
          end
          expose :name, documentation: {:type => "String", :desc => "Taxi Name"}
          expose :path, documentation: {:type => "Text", :desc => "Taxi Path"}
          expose :attachment, documentation: {:type => "Text", :desc => "Taxi attachment"} do |object, options|
            object.attachment.url
          end
        end

        class Utility < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Utility ID"}
          expose :top_advertisements, if: lambda { |object, options| options[:simple] == 'false' }  do |discover, options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["top"])
          end
          expose :photo, documentation: {:type => "String", :desc => "Utility Photo"} do |disc, options|
            disc.photo.url
          end
          expose :bottom_advertisements, if: lambda { |object, options| options[:simple] == 'false' }  do |discover, options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["bottom"])
          end
        end

        class Weather < Grape::Entity
          expose :temperature do |weather, options|
            weather.currently[:temperature]
          end
          expose :weather_icon do |weather, options|
            weather.currently[:icon]
          end
          expose :weather_message do |weather, options|
            weather.currently[:summary]
          end
        end

        class Home < Grape::Entity
          expose :photo do |home , options|
            home.photo.url
          end
          expose :weather, if: lambda { |object, options| options[:simple] == 'false'  }  do |home, options|
            CityWay::Api::V1::Entities::Weather.represent options[:forecast]
          end
          expose :top_advertisements, if: lambda { |object, options| options[:simple] == 'false'  }  do |home , options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["top"])
          end
          expose :categories, if: lambda { |object, options| options[:simple] == 'false'  }  do |home , options|
            CityWay::Api::V1::Entities::Category.represent(home.categories)
          end
          expose :bottom_advertisements, if: lambda { |object, options| options[:simple] == 'false'  }  do |home , options|
            CityWay::Api::V1::Entities::Advertisement.represent(options[:advertisements]["bottom"])
          end
        end

        class City < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "City ID"}, if: lambda { |object, options| !object.id.blank? }
          expose :name, documentation: {:type => "string", :desc => "City Name"}
          expose :latitude, documentation: {:type => "float", :desc => "City Latitude"}
          expose :longitude, documentation: {:type => "float", :desc => "City Longitude"}
          expose :distance, if: lambda { |object, options| object.respond_to?(:distance) }
          expose :home, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'home'  } do |city, options|
            CityWay::Api::V1::Entities::Home.represent(city, options)
          end
          expose :around, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'around' } do |city, options|
            CityWay::Api::V1::Entities::Around.represent(city.around, options)
          end
          expose :commonplace, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'city_hall' }, as: 'city_hall' do |city, options|
            CityWay::Api::V1::Entities::Commonplace.represent(city.commonplace, options)
          end
          expose :discover, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'discover' } do |city, options|
            CityWay::Api::V1::Entities::Discover.represent(city.discover, options)
          end
          expose :utility, if: lambda { |object, options| options[:sections].blank? || options[:sections] == 'utility' } do |city, options|
            CityWay::Api::V1::Entities::Utility.represent(city.utility, options)
          end
        end

        class CityWithoutSection < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "City ID"}, if: lambda { |object, options| !object.id.blank? }
          expose :name, documentation: {:type => "string", :desc => "City Name"}
          expose :latitude, documentation: {:type => "float", :desc => "City Latitude"}
          expose :longitude, documentation: {:type => "float", :desc => "City Longitude"}
          expose :distance, if: lambda { |object, options| object.respond_to?(:distance) }
        end

        class CityStructure < Grape::Entity
          expose :nearest_city do |city, options|
            CityWay::Api::V1::Entities::CityWithoutSection.represent city, message: options[:message], simple: options[:simple]
          end
          expose :message do |city, options|
            options[:message]
          end
          expose :actual_city , if: lambda { |instance, options| options[:actual_city] } do |cities, options|
            options[:actual_city]
          end
          expose :nearby_cities, if: lambda { |instance, options| options[:cities] && options[:list] } do |cities, options|
            CityWay::Api::V1::Entities::CityWithoutSection.represent options[:cities], simple: options[:simple]
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
          expose :subcategories,if: lambda { |object, options| !object.parent_id && object.subcategories.length > 0 } do |category, options|
            CityWay::Api::V1::Entities::Category.represent(category.subcategories)
          end
        end

        class CategoryWithMerchants < Grape::Entity
          expose :merchants do |category , options|
            CityWay::Api::V1::Entities::Merchant.represent(options[:merchants] , latitude: options[:latitude], longitude: options[:longitude])
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
          expose :evening_open_time, if: lambda{ |object, options| !object.evening_open_time.blank? } do |business_hour , options|
            business_hour.evening_open_time.strftime("%H:%M")
          end
          expose :evening_close_time, if: lambda{ |object, options| !object.evening_close_time.blank? } do |business_hour , options|
            business_hour.evening_close_time.strftime("%H:%M")
          end
          expose :is_open do |business_hour , options|
            business_hour.is_open? Time.now
          end
        end

        class Photo < Grape::Entity
          expose :picture, as: 'photo' do |photo, options|
            if photo.class.name == 'Photo'
              photo.picture.url
            else
              photo.url
            end
          end
          expose :position ,if: lambda { |object, options| object.respond_to?(:position) && object.class.name == 'Photo' }
        end

        class Merchant < Grape::Entity
          expose :id, documentation: {:type => "integer", :desc => "Merchant ID"}
          expose :type , documentation: {:type => "integer", :desc => "Merchant Type"} do |object, options|
            object.class.name.downcase
          end
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
          expose :phone,if: lambda { |object, options| options[:simple] == 'false'  && object.phone }, documentation: {:type => "string", :desc => "Merchant phone"}
          expose :email,if: lambda { |object, options| options[:simple] == 'false' && object.email }, documentation: {:type => "string", :desc => "Merchant email"}
          expose :website, if: lambda { |object, options| options[:simple] == 'false' && object.website }, documentation: {:type => "string", :desc => "Merchant website"} do |merchant, options|
            unless merchant.website[/\Ahttp:\/\//] || merchant.website[/\Ahttps:\/\//]
              "https://#{merchant.website}"
            else
              merchant.website
            end
          end
          expose :facebook, if: lambda { |object, options| options[:simple] == 'false' && object.facebook },
          documentation: {:type => "string", :desc => "Merchant facebook"} do |merchant, options|
            matches = merchant.facebook.match(/(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:groups\/)?(?:pages\/)?(?:[\w\-]*\/)*?(\/)?([\w\-\.]*)/)
            if matches
              matches[2]
            else
              merchant.facebook
            end
          end
          expose :instagram, if: lambda { |object, options| options[:simple] == 'false' && object.instagram }, documentation: {:type => "string", :desc => "Merchant instagram"} do |merchant, options|
            unless merchant.instagram[/\Ahttp:\/\//] || merchant.instagram[/\Ahttps:\/\//]
              "https://#{merchant.instagram}"
            else
              merchant.instagram
            end
          end
          expose :twitter, if: lambda { |object, options| options[:simple] == 'false' && object.twitter }, documentation: {:type => "string", :desc => "Merchant twitter"} do |merchant, options|
            unless merchant.twitter[/\Ahttp:\/\//] || merchant.twitter[/\Ahttps:\/\//]
              "https://#{merchant.twitter}"
            else
              merchant.twitter
            end
          end
          expose :google_plus, if: lambda { |object, options| options[:simple] == 'false' && object.google_plus }, documentation: {:type => "string", :desc => "Merchant G+"} do |merchant, options|
            unless merchant.google_plus[/\Ahttp:\/\//] || merchant.google_plus[/\Ahttps:\/\//]
              "https://#{merchant.google_plus}"
            else
              merchant.google_plus
            end
          end
          expose :support_disabilities, documentation: {:type => "boolean", :desc => "Merchant support_disabilities"}
          expose :distance, if: lambda { |object, options| object.respond_to?(:distance) || options[:latitude] && options[:longitude] } do |merchant , options|
            merchant.distance_from([options[:latitude], options[:longitude]])
          end
          expose :has_promos, documentation: {:type => "Boolean", :desc => "Merchant Has Promos Or Not"} do |merchant , options|
            merchant.promos.any?
          end
          expose :business_hours,if: lambda { |object, options| options[:simple] == 'false' } do |merchant , options|
            CityWay::Api::V1::Entities::BusinessHours.represent(merchant.all_business_hours)
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

        class Message < Grape::Entity
          expose :id, documentation: {:type => "Integer", :desc => "Message id"}
          expose :firstname, documentation: {:type => "String", :desc => "Message firstname"}
          expose :lastname, documentation: {:type => "String", :desc => "Message lastname"}
          expose :email, documentation: {:type => "String", :desc => "Message email"}
          expose :message, documentation: {:type => "String", :desc => "Message content"}
          expose :message_type, documentation: {:type => "Integer", :desc => "Message message_type"}
        end
      end
    end
  end
end
