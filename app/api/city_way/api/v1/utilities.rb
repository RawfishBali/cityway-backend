module CityWay
  module Api
    module V1
      class Utilities < Grape::API
        version 'v1'
        format :json

        resources :utilities do
          before do
            authenticate!
          end

          desc "devices list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            requires :device_type, type: String, values: -> { ["wifi", "webcam"] }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/devices' do
            utility = Utility.find(params[:id])
            present utility.devices_by_type(params[:device_type]), with: CityWay::Api::V1::Entities::Device, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

          desc "Useful Number list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
          end
          get '/:id/useful_numbers' do
            utility = Utility.find(params[:id])
            present utility.utility_numbers, with: CityWay::Api::V1::Entities::UtilityNumber
          end

          desc "Places list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            optional :place_type, type: String, values: -> { ["post_office","pharmacies","water_house","waste_recycling","bikes","public_swimming_pool","tennis_court","stadium","structures","social_services","voluntary_association","elder_home","young_people_place","kindergarten","primary_school","first_secondary_school","second_secondary_school","universities","music"] }
            optional :public, type: Boolean
            optional :commercial, type: Boolean
            optional :place_group, type: String
            optional :latitude, type: Float
            optional :longitude, type: Float
            optional :simple, type: Boolean
          end
          get '/:id/places' do
            simple = params[:simple] || true
            utility = Utility.find(params[:id])
            if params[:place_group]
              if params[:place_group] == 'sports'
                present utility, with: CityWay::Api::V1::Entities::UtilitySports, simple: simple, latitude: params[:latitude], longitude: params[:longitude]
              elsif params[:place_group] == 'schools'
                present utility, with: CityWay::Api::V1::Entities::UtilitySchools, simple: simple, latitude: params[:latitude], longitude: params[:longitude]
              elsif params[:place_group] == 'socials'
                present utility, with: CityWay::Api::V1::Entities::UtilitySocials, simple: simple, latitude: params[:latitude], longitude: params[:longitude]
              end
            else
              present utility.places_by_type(params[:place_type], params[:public], params[:commercial]), with: CityWay::Api::V1::Entities::UtilityPlaceEntitiy, simple: simple, latitude: params[:latitude], longitude: params[:longitude]
            end

          end

          desc "Place Detail"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            requires :place_id , type: Integer, values: -> { UtilityPlace.ids }
          end
          get '/:id/places/:place_id' do
            utility = Utility.find(params[:id])
            present utility.utility_places.find_by(id: params[:place_id]), with: CityWay::Api::V1::Entities::UtilityPlaceEntitiy, simple: 'false', latitude: params[:latitude], longitude: params[:longitude], private: params[:private]
          end

          desc "Transportation list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            requires :transportation_type, type: String, values: -> { ["bus", "regional_bus", "autobus", "tram", "underground"] }
          end
          get '/:id/transportations' do
            utility = Utility.find(params[:id])
            present utility.transportation_by_type(params[:transportation_type]), with: CityWay::Api::V1::Entities::PublicTransport, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

          desc 'Moving Within City'
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            optional :type , type: String, values: -> { ['taxi','bike','parking'] }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/vehicles' do
            utility = Utility.find(params[:id])
            if params[:type]
              vehicles = utility.vehicles_by_type params[:type]
            else
              vehicles = utility.vehicles
            end
            present vehicles, with: CityWay::Api::V1::Entities::Vehicle, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

          desc "GarbageGlossary list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/glossaries' do
            utility = Utility.find(params[:id])
            present utility.garbage_glossaries, with: CityWay::Api::V1::Entities::GarbageGlossary
          end

          desc "ZTL list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/ztls' do
            utility = Utility.find(params[:id])
            present utility.ztls, with: CityWay::Api::V1::Entities::Ztl
          end

          desc "Sports list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/sports' do
            utility = Utility.find(params[:id])
            present utility, with: CityWay::Api::V1::Entities::UtilitySports, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end
        end
      end
    end
  end
end
