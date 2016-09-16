module CityWay
  module Api
    module V1
      class CityHalls < Grape::API
        version 'v1'
        format :json

        resources :city_halls do
          before do
            authenticate!
          end

          desc "CityHall Detail"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id' do
            commonplace = Commonplace.find(params[:id])
            advertisements = commonplace.city.active_advertisements
            present commonplace, with: CityWay::Api::V1::Entities::Commonplace, simple: 'false', latitude: params[:latitude], longitude: params[:longitude], advertisements: advertisements
          end


          desc "CityHall Public Offices"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/public_offices' do
            commonplace = Commonplace.find(params[:id])
            offices = commonplace.public_offices.page params[:page]
            add_pagination_headers offices

            present offices, with: CityWay::Api::V1::Entities::PublicOffice, simple: 'false'
          end


          desc "CityHall Securities"
          params do
            requires :id , type: Integer, values: -> { Commonplace.ids }
            optional :latitude, type: Float
            optional :longitude, type: Float
          end
          get '/:id/securities' do
            commonplace = Commonplace.find(params[:id])
            securities = commonplace.securities.page params[:page]
            add_pagination_headers securities

            present securities, with: CityWay::Api::V1::Entities::Security, simple: 'false'
          end

        end
      end
    end
  end
end
