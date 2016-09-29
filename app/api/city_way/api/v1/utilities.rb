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
            requires :place_type, type: String, values: -> { ["post_office","pharmacies","water_house","waste_recycling","bikes","public_swimming_pool","tennis_court","stadium","structures","social_services","voluntary_association","elder_home","young_people_place","kindergardern","primary_school","first_secondary_school","second_secondary_school","universities","music"] }
            optional :private, type: Boolean
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/places' do
            utility = Utility.find(params[:id])
            present utility.places_by_type(params[:place_type]), with: CityWay::Api::V1::Entities::UtilityPlace, simple: 'false', latitude: params[:latitude], longitude: params[:longitude], private: params[:private]
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

          desc "Taxi list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/taxis' do
            utility = Utility.find(params[:id])
            present utility.taxis, with: CityWay::Api::V1::Entities::Taxi, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
          end

          desc "Parking Area list"
          params do
            requires :id , type: Integer, values: -> { Utility.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/parking_areas' do
            utility = Utility.find(params[:id])
            present utility.parking_areas, with: CityWay::Api::V1::Entities::ParkingArea, simple: 'false', latitude: params[:latitude], longitude: params[:longitude]
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
        end
      end
    end
  end
end
